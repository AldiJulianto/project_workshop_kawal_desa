import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:project_workshop_kawal_desa/ui/shared/shared_style.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';
import 'package:project_workshop_kawal_desa/viewmodels/sign_up_view_model.dart';

class FormImageData extends StatelessWidget {
  SignUpViewModel model;
  FormImageData({this.model});
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: model.busy,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Foto KTP",
                    style: homeNameTextStyle.copyWith(fontSize: 17),
                  ),
                  verticalSpaceSmall,
                  InkWell(
                    onTap:() async {
                      await model.cameraView("KTP");
                    },
                    child: Container(
                        padding: fieldPadding,
                        width: screenWidthPercent(context, multipleBy: 0.83),
                        height: screenHeightPercent(context, multipleBy: 0.25),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.greenAccent,
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: model.isPathNull("KTP") == false
                            ? Center(
                            child: Text(
                              "Upload KTP/ID Card",
                              style: textButtonTextStyle,
                            )
                        ) : Image.file(File(model.imagePath), fit: BoxFit.cover)
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Foto Profile",
                    style: homeNameTextStyle.copyWith(fontSize: 17),
                  ),
                  verticalSpaceSmall,
                  InkWell(
                    onTap: () async {
                      await model.cameraView("Profile");
                    },
                    child: Container(
                      padding: fieldPadding,
                      width: screenWidthPercent(context, multipleBy: 0.83),
                      height: screenHeightPercent(context, multipleBy: 0.25),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.greenAccent,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: model.isPathNull("Profile") == false
                          ? Center(
                          child: Text(
                            "Upload Foto Profile",
                            style: textButtonTextStyle,
                          )
                      ) : Image.file(File(model.imagePathProfile), fit: BoxFit.cover,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}