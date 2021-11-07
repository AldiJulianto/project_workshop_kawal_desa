import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:project_workshop_kawal_desa/locator.dart';
import 'package:project_workshop_kawal_desa/models/send_absen.dart';
import 'package:project_workshop_kawal_desa/models/report_data.dart';
import 'package:project_workshop_kawal_desa/models/absen_data.dart';
import 'package:project_workshop_kawal_desa/services/api_service.dart';
import 'package:project_workshop_kawal_desa/services/database_handler.dart';
import 'package:project_workshop_kawal_desa/services/geolocator_service.dart';
import 'package:project_workshop_kawal_desa/services/navigation_service.dart';
import 'package:project_workshop_kawal_desa/services/storage_service.dart';
import 'package:project_workshop_kawal_desa/viewmodels/base_model.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart' as collect;

class ReportViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final GeolocatorService _geolocatorService = locator <GeolocatorService>();
  final DatabaseHandler _handler = locator <DatabaseHandler>();

  bool isLoading = false;
  int totalPages = 0;
  int pages = 1;
  double lat = 0.0;
  double lng = 0.0;
  String address = '';
  ReportData data;
  List<AbsenData> absenData = List();

  void onModelReady (){
    print('Init');
    _handler.initializeDB().whenComplete(() async {
      print('Initialized');
    });

    final data = _handler.retrieveUsers();
    data.then((value) {
      print(value.length);
      value.forEach((val) {
        absenData.add(AbsenData(
         address: val.address,
         description: val.description,
         image: val.image,
         name: val.name,
         timestamp: int.parse(val.timestamp),
         localImage: val.localImage,
         send: val.send
        ));
      });
    });

    getAllReport(pages);
    collect.mergeSort(absenData);
    collect.reverse(absenData);
    getLocation();
  }

  void goAnotherView(String routeName) async {
    final data = await _navigationService.navigateTo(routeName);
    if(data == null){
      getAllReport(1);
    }
  }

  void getAllReport(int page) async {
    data = null;
    absenData.clear();
    final company = await _storageService.getString(K_COMPANY);
    final guid = await _storageService.getString(K_GUID);
    data = await _apiService.getReport(company, guid, page);
    data.data.forEach(
            (val) {
              absenData.add(
                AbsenData(
                  address: val.address,
                  description: val.description,
                  id: val.id,
                  image: val.image,
                  name: val.name,
                  timestamp: val.timestamp,
                  localImage: val.localImage,

                )
              );
            });
    setBusy(false);
  }

  void loadMoreData(int page) async {
    isLoading = true;
    if(page <= totalPages) {
      final company = await _storageService.getString(K_COMPANY);
      final guid = await _storageService.getString(K_GUID);
      data = await _apiService.getReport(company, guid, page);
      data.data.forEach(
              (val) {
            absenData.add(
                AbsenData(
                  address: val.address,
                  description: val.description,
                  id: val.id,
                  image: val.image,
                  name: val.name,
                  timestamp: val.timestamp,
                  localImage: val.localImage,
                )
            );
          });
      isLoading = false;
      setBusy(false);
    }else {
      page = totalPages;
      isLoading = false;
    }
  }

  String formatDate(int date) {
    var tempData = new DateTime.fromMillisecondsSinceEpoch(date*1000, isUtc: false);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    var returnData = dateFormat.format(tempData);
    return returnData;
  }

  Future<void> getLocation() async {
    try {
      final userLocation = await _geolocatorService.getCurrentLocation();
      lat = userLocation.latitude;
      lng = userLocation.longitude;
      address = userLocation.addressLine;
      setBusy(false);
    }catch(e) {
      setBusy(false);
    }
  }
}