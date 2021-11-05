import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';
import 'package:project_workshop_kawal_desa/viewmodels/startup_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (model) => model.startUpTimer(),
        builder: (context, model, child) => Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                verticalSpaceMedium,
                Text (
                  'Register Kawal Desa',
                ),
                verticalSpaceSmall,
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Image.asset('assets/logo.png'),
                )
              ],
            ),
          ),
        ),
    );
  }
}
