import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/ui/views/camera_view.dart';
import 'package:project_workshop_kawal_desa/ui/views/dashboard_view.dart';
import 'package:project_workshop_kawal_desa/ui/views/login_view.dart';
import 'package:project_workshop_kawal_desa/ui/views/sign_up_view.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){

    case LoginViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: LoginView()
      );

    case SignUpViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: SignUpView()
      );

    case CameraViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: CameraView()
      );
    case DashboardViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: DashboardView()
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No Route Defined For ${settings.name}'
              ),
            ),
          )
      );
  }
}

PageRoute _pageRoute({String routeName, Widget viewToShow}){
  return MaterialPageRoute(
      builder: (_) => viewToShow,
      settings: RouteSettings(
        name: routeName
      )
  );
}