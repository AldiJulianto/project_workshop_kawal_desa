import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';
import 'package:project_workshop_kawal_desa/viewmodels/dashboard_view_model.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Dashboard Register'
            ),
          ),
          body: SingleChildScrollView (
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Login Berhasil",
                          style: TextStyle(
                            fontSize: 40
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          MaterialButton(
                              onPressed: (){
                                model.signOut(context);
                              },
                            child: Text (
                              "Log Out"
                            ),
                          ),
                          horizontalSpaceMedium,
                          MaterialButton(
                              onPressed: (){
                                model.goAnotherView(AbsenViewRoute);
                              },
                            child: Text(
                              "Pelaporan"
                            ),
                          ),
                        ],
                      )
                    ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
