import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop(){
    return _navigationKey.currentState.pop();
  }

  void popUpWithValue(String value){
    return _navigationKey.currentState.pop('$value');
  }

    Future<dynamic> navigateTo(String routeName, {dynamic arguments}){
    return _navigationKey.currentState.pushNamed(routeName, arguments: arguments);
    }

    Future<dynamic> navigateToWithData(String routName, data, {dynamic arguemnts}){
    return _navigationKey.currentState.pushNamedAndRemoveUntil(routName, (route) => false);
    }

    Future<dynamic> replaceTo(String routeName, {dynamic arguments}){
      return _navigationKey.currentState.pushNamedAndRemoveUntil(routeName, (route) => false);
    }
}