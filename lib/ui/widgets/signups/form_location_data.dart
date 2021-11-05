import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';
import 'package:project_workshop_kawal_desa/viewmodels/sign_up_view_model.dart';

class FormLocationData extends StatelessWidget {
  SignUpViewModel model;
  FormLocationData({this.model});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoadingOverlay(
        isLoading: model.busy,
        child: SafeArea (
          child: SingleChildScrollView (
            child: Container(
              child: Center(
                child: Column (
                  children: <Widget> [
                    Container(
                      width: size.width,
                      height: size.height*0.8,
                      child: FlutterMap (
                        options: MapOptions(
                          center: LatLng (
                            model.lat, model.long
                          ),
                          zoom: 13.0,
                          onTap: model.handleTap
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate: "hhtps://{s}.tileo.openstreetMap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']
                          ),
                          MarkerLayerOptions (
                            markers: model.myPoint
                          )
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField (
                      maxLines: 5,
                      controller: model.addressController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide (
                            color: color_main
                          )
                        ),
                        border: OutlineInputBorder(),
                      ),
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
