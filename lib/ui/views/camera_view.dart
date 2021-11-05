import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';
import 'package:project_workshop_kawal_desa/viewmodels/camera_view_,model.dart';
import 'package:stacked/stacked.dart';

class CameraView extends StatefulWidget {

  @override
  _CameraViewState createState() {
    return _CameraViewState();
  }
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraViewModel>.reactive(
      viewModelBuilder: () => CameraViewModel(),
      onModelReady: (model) => model.initModel(mounted),
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                Expanded(
                  child: _cameraPreviewWidget(model.controller),
                  flex: 1,
                ),
                verticalSpaceSmall,
                Row (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _cameraTogglesRowWidget(model, mounted),
                    _captureControlRowWidget(context, model),
                    Spacer()
                  ],
                ),
                verticalSpaceMedium
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget(CameraController controller){
    if(controller == null || !controller.value.isInitialized){
      return Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900
        ),
      );
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  Widget _captureControlRowWidget(context, CameraViewModel model) {
    final size = MediaQuery.of(context).size;
    final cameraOne =  size.width*0.2;
    final cameraTwo =  size.width*0.1;

    return Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () => model.onCapturePressed(context),
                child: Container(
                  height: cameraOne,
                  width: cameraOne,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        spreadRadius: 16,
                        color: Colors.black.withOpacity(0.2)
                      )
                    ],
                  ),
                  child: Container(
                    height: cameraTwo,
                    width: cameraTwo,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(300),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2)
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _cameraTogglesRowWidget(CameraViewModel model, bool mounted){
    if(model.cameras == null || model.cameras.isEmpty){
      return Spacer();
    }

    CameraDescription selectedCamera = model.cameras[model.selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: (){
              model.onSwitchedCamera(mounted);
            },
            icon: Icon(_getCameraLensIcon(lensDirection)),
            label: Text(
              "${lensDirection.toString().substring(lensDirection.toString().indexOf('.')+ 1)}"
            )
        ),
      )
    );
  }
  IconData _getCameraLensIcon (CameraLensDirection direction) {
    switch(direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
    }
  }
}
