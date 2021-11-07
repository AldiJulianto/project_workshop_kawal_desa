import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/models/absen_data.dart';
import 'package:project_workshop_kawal_desa/models/trajectory_data.dart';
import 'package:location/location.dart';
import 'package:project_workshop_kawal_desa/locator.dart';
import 'package:project_workshop_kawal_desa/services/alert_service.dart';
import 'package:project_workshop_kawal_desa/services/ftp_service.dart';
import 'package:project_workshop_kawal_desa/services/geolocator_service.dart';
import 'package:project_workshop_kawal_desa/services/location_service.dart';
import 'package:project_workshop_kawal_desa/services/navigation_service.dart';
import 'package:project_workshop_kawal_desa/services/rmq_service.dart';
import 'package:project_workshop_kawal_desa/services/storage_service.dart';
import 'package:project_workshop_kawal_desa/viewmodels/base_model.dart';

import 'package:latlong/latlong.dart';
import 'package:path/path.dart';

class TrajectoryViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final GeolocatorService _geolocatorService = locator<GeolocatorService>();
  final StorageService _storageService = locator<StorageService>();
  final AlertService _alertService = locator<AlertService>();
  final FtpService _ftpService = locator<FtpService>();
  final RmqService _rmqService = locator<RmqService>();
  final LocationService _locationService = locator<LocationService>();
  var items = ['Lahan Warga', 'Batas Desa'];
  String jenisReport = "Lahan Warga";
  String Reportype = '';
  Location location = new Location();
  bool _serviceEnabled;
  double latitude = 0.0;
  double longitude = 0.0;
  String Lat = '';
  String Long = '';

  String imagePath = '';
  String imageName = '';
  double lat = 0.0;
  double lng = 0.0;
  String address = '';
  String pathLocation = 'data/kehadiran/image';
  List<ItemLocation> itemLocation = [];
  List<MAPBOUNDARIES> maps = [];
  var Json = <ItemLocation>[];
  var data = <LatLng>[];
  Future<void> setPoline(BuildContext context) async {
    setBusy(true);
    if(itemLocation.length == 0){
      setBusy(false);
      _alertService.showWarning(context, "Warning", "Anda belum menentukan titik koordinat", _navigationService.pop);

    }else{
      data.add(data[0]);
      setBusy(false);
    }
  }

  Future<void> DeleteList() async{
    setBusy(true);
    List<ItemLocation> item = itemLocation;
    item.clear();
    List<LatLng> itemlatlong = data;
    itemlatlong.clear();
    setBusy(false);
  }

  Future<void> turnOnLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        await turnOnLocation();
      }
    }
  }

  void getReportType() async {
    if(jenisReport == 'Batas Desa'){
      Reportype = 'MHMWA';
    }else if(jenisReport == "Lahan Warga"){
      Reportype = 'D9XJF';
    }
  }

  void init() async {
    latitude = double.parse(await _storageService.getString(K_LATITUDE));
    longitude = double.parse(await _storageService.getString(K_LONGITUDE));
    await turnOnLocation();
    await getLocation();
  }

  Future<void> saveLocation() async {
    setBusy(true);
    getLocation();
    itemLocation.add(new ItemLocation(longitude, latitude));
    data.add(LatLng(latitude, longitude));
    Json.add(ItemLocation(longitude, latitude));
    maps.add(MAPBOUNDARIES(lat: latitude, lng: longitude));
    setBusy(false);
  }

  Future<void> getLocation() async {
    setBusy(true);
    try{
      final userLocation = await _geolocatorService.getCurrentLocation();
      final itemLocation = ItemLocation(userLocation.longitude, userLocation.latitude);
      latitude = userLocation.latitude;
      longitude = userLocation.longitude;
      address = userLocation.addressLine;
      String Lat = latitude.toString();
      String Long = longitude.toString();

      await _storageService.setString(K_LATITUDE, Lat);
      await _storageService.setString(K_LONGITUDE, Long);

      setBusy(false);
      return itemLocation;
    } catch(e){
      setBusy(false);
    }
  }

  Future<void> SaveTrajectory(BuildContext context) async {
    setBusy(true);
    getReportType();
    if(itemLocation.length == 0){
      setBusy(false);
      _alertService.showWarning(context, "Warning", "Anda belum menentukan titik koordinat", _navigationService.pop);
    } else{
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final timestamp = date.substring(0,10);
      final name = await _storageService.getString(K_NAME);
      final company = await _storageService.getString(K_COMPANY);
      final unit = await _storageService.getString(K_UNIT);
      final guid = await _storageService.getString(K_GUID);

      String network = '';
      try{
        final result = await InternetAddress.lookup('google.com');
        if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
          network = 'connected';
        }
      }on SocketException catch (_){
        network = 'disconnected';
      }

      var absenData = data_trajectory(
          aDDRESS: '$address',
          cMDTYPE: 0,
          cOMPANY: '$company',
          dESCRIPTION: 'Report lahan Warga',
          gUID: '$guid',
          iMAGE: '$pathLocation$guid$timestamp-PPTIK.jpg',
          lAT: '$latitude',
          lONG: '$longitude',
          lOCALIMAGE: '$pathLocation$guid$timestamp-PPTIK.jpg',
          mSGTYPE: 1,
          nAME: '$name',
          sTATUS: '$jenisReport',
          tIMESTAMP: '$timestamp',
          uNIT: '$unit',
          mAPBOUNDARIES: maps,
          rEPORTTYPE: '$Reportype'
      );
      final sendAbsen = sendAbsenToJson(absenData);
      if(network=='connected'){
        _rmqService.publish(sendAbsen);
        _alertService.showSuccess(
            context,
            "Success",
            "Data Berhasil di Kirim",
                (){
              _navigationService.replaceTo(DashboardViewRoute);
            }
        );
        setBusy(false);
      }else{
        setBusy(false);
        _alertService.showWarning(context, "Warning", "Connection problem to server", _navigationService.pop);
      }
    }
  }
}

class ItemLocation{
  double longitude;
  double latitude;
  ItemLocation(this.longitude, this.latitude);
}