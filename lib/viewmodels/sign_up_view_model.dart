
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/services/alert_service.dart';
import 'package:project_workshop_kawal_desa/services/api_service.dart';
import 'package:project_workshop_kawal_desa/services/geolocator_service.dart';
import 'package:project_workshop_kawal_desa/services/location_service.dart';
import 'package:project_workshop_kawal_desa/services/navigation_service.dart';
import 'package:project_workshop_kawal_desa/viewmodels/base_model.dart';

import '../locator.dart';

class SignUpViewModel extends BaseModel{
  String unitSelected;
  String company;
  String imagePath = "";
  String imagePathKk = "";
  String imagePathProfile = "";

  double lat = 0.0;
  double long = 0.0;

  List<String> units = List();
  List<Marker> myPoint = [];

  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();
  final GeolocatorService _geolocatorService = locator<GeolocatorService>();
  final AlertService _alertService = locator<AlertService>();

  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idCardController = TextEditingController();


  void onUnitChangeSelect(String value){
    unitSelected = value;
    setBusy(false);
  }

  bool changeVisibility(){
    if (units == null || units.isEmpty){
      return false; 
    }else{
      return true;
    }
  }

  void getCompanyUnit(String code) async{
    setBusy(false);
    units.clear();
    unitSelected = null;
    final unit = await _apiService.getCompanyUnit(code);
    if(unit != null ) {
      unit.data.forEach((value) { units.add(value);
      });
    }
    setBusy(false);
  }

  Future<void> cameraView(String type) async {
    setBusy(true);
    final path = await _navigationService.navigateTo(CameraViewRoute);
    if (type == "KTP"){
      imagePath = path.toString().split('#')[0];
    } else if (type == "KK"){
      imagePathKk = path.toString().split('#')[0];
    } else if (type == "Profile"){
      imagePathProfile = path.toString().split('#')[0];
    }
    setBusy(false);
  }

  bool isPathNull(String type){
    if (type == "KTP") {
      if (imagePath == null  || imagePath.isEmpty) {
        return false;
      } else if (type == "KK" || imagePathKk.isEmpty) {
        return false;
      } else if (type == "Profile" || imagePathProfile.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void handleTap(LatLng latLng) {
      setBusy(true);
      lat = latLng.latitude;
      long = latLng.longitude;
      myPoint.clear();
      myPoint.add(Marker(
        width: 80.0,
        height: 80.0,
        point: latLng,
        builder: (ctx) => Container(
          child: Icon(Icons.location_on),
        )
      ));
      setBusy(false);
  }

  void openLocationSetting() async {
    await _locationService.checkService();
  }

  Future<void> getLocation() async {
    setBusy(false);
    try {
      myPoint.clear();
      final userLocation = await _geolocatorService.getCurrentLocation();
      lat = userLocation.latitude;
      long = userLocation.longitude;

      myPoint.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(lat, long),
          builder: (ctx) => Container(
            child: Icon(Icons.location_on),
          )
      ));
      setBusy(false);
    } catch (e){
      setBusy(false);
    }
  }


  void register(BuildContext context) async{
    setBusy(false);
    try {
      if(nameController.text.length != null &&
          positionController.text.length != null &&
          emailController.text.length != null &&
          passwordController.text.length != null &&
          phoneNumberController.text.length != null &&
          company.length != null &&
          unitSelected.length != null &&
          imagePath.length != null) {
        final name = nameController.text;
        final email = emailController.text;
        final position = positionController.text;
        final password = passwordController.text;
        final phoneNumber = phoneNumberController.text;
        final idCard = idCardController.text;
        final companys = company;

        final data = await _apiService.register(
            name,
            email,
            password,
            position,
            idCard,
            company,
            imagePath,
            unitSelected,
            phoneNumber,
            File(imagePath),
            File(imagePathProfile),
            addressController.text,
            long.toString(),
            lat.toString(),
            'aparat');
        if (data.code == 200) {
          setBusy(false);
          _alertService.showAlert(context, "Success", "Successfully Registered", (){
            _navigationService.replaceTo(LoginViewRoute);
          });
        } else {
          setBusy(false);
          _alertService.showAlert(context, "Error", "Something went Wrong ${data.message}", _navigationService.pop);
        }
      } else {
        setBusy(false);
        _alertService.showAlert(context, "Warning", "Please Fill all Fields", _navigationService.pop);
      }
    } catch (e) {
      _alertService.showAlert(context, "Error", "Check your registration code", _navigationService.pop);
    }
  }

  void backToLogin(){
    _navigationService.navigateTo(LoginViewRoute);
  }

  void initState () async {
    setBusy(false);
    await openLocationSetting();
    await getLocation();
    setBusy(false);
  }

}