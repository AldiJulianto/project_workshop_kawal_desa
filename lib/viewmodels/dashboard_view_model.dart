import 'package:flutter/cupertino.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/locator.dart';
import 'package:project_workshop_kawal_desa/services/alert_service.dart';
import 'package:project_workshop_kawal_desa/services/navigation_service.dart';
import 'package:project_workshop_kawal_desa/services/storage_service.dart';
import 'package:project_workshop_kawal_desa/viewmodels/base_model.dart';

class DashboardViewModel extends BaseModel {
  final StorageService _storageService = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AlertService _alertService = locator<AlertService>();

  String name="";
  String K_NAME= 'name';

  void initData(BuildContext context) async {
    setBusy(true);
    name = await _storageService.getString('name');
    setBusy(false);
  }

  void clearBeforeSignOut() async {
    await _storageService.clearStorage();
    _navigationService.replaceTo(LoginViewRoute);
  }

  void signOut(BuildContext context) {
    setBusy(true);
    _alertService.showSignOut(context, "Sign Out?", '', clearBeforeSignOut, _navigationService.pop);
    setBusy(false);
  }

  void goAnotherView(String routeName) async {
    await _navigationService.navigateTo(routeName);
  }
}