import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';

//Viewmodelnya akan dibuatkan nanti
import 'package:project_workshop_kawal_desa/viewmodels/trajectory_view_model.dart';

import 'package:stacked/stacked.dart';

class TrajectoryView extends StatefulWidget {
  _TrajectoryViewState createState() => _TrajectoryViewState();
}

class _TrajectoryViewState extends State<TrajectoryView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  var point = <LatLng>[
    LatLng(-6.8559854, 107.6117385),
    LatLng(-6.8559142, 107.6117418),
    LatLng(-6.855979, 107.6114233),
    LatLng(-6.8559854, 107.6117385)
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<TrajectoryViewModel>.reactive(
      viewModelBuilder: () => TrajectoryViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: LoadingOverlay(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, size.width * 0.15, 10, 0),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back)
                            ),
                            Expanded(
                              child: Text(
                                "Trajecctory",
                                style: TextStyle(
                                    color: color_independent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                ),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          child: Text("Ambil Lokasi"),
                          style: ElevatedButton.styleFrom(
                              primary: color_independent //color_mandarin
                          ),
                          onPressed: (){
                            model.saveLocation();
                          },
                        ),
                        OutlineButton(
                          borderSide: BorderSide(
                              color: color_spacecafet
                          ),
                          highlightedBorderColor: color_independent, //color_mandarin
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () => model.setPoline(context),
                          child: Text("Tampilkan Garis"),
                        ),
                        SizedBox(height: 10,),
                        Text("Ppilih Jenis Trajectory"),
                        DropdownButton(
                          value: model.jenisReport,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: model.items.map((String items){
                            return DropdownMenuItem(
                                value: items,
                                child: Text(items)
                            );
                          }).toList(),
                          onChanged: (String newValue){
                            setState((){
                              model.jenisReport = newValue;
                            });
                          },
                        ),
                        OutlineButton(
                          borderSide: BorderSide(
                              color: color_spacecafet
                          ),
                          highlightedBorderColor: color_independent, //color_mandarin
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () => model.SaveTrajectory(context),
                          child: Text("Kirim Data"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.itemLocation.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0))
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Longitude",
                                            style: TextStyle(
                                                color: color_independent,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            "${model.itemLocation[index].longitude}",
                                            style: TextStyle(
                                              color: color_independent,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                            "${model.itemLocation[index].latitude}",
                                            style: TextStyle(
                                              color: color_independent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          height: size.height*0.7,
                          child: FlutterMap(
                            options: MapOptions(
                                center: LatLng(model.latitude, model.longitude),
                                zoom: 1.0
                            ),
                            layers: [
                              PolylineLayerOptions(
                                polylines: [
                                  Polyline(
                                      points: model.data,
                                      strokeWidth: 4.0,
                                      color: Colors.red
                                  ),
                                ],
                              ),
                            ],
                            children:<Widget> [
                              TileLayerWidget(
                                options: TileLayerOptions(
                                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}/png",
                                    subdomains: ['a', 'b', 'c']
                                ),
                              ),
                              MarkerLayerWidget(
                                options: MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: LatLng(model.latitude, model.longitude),
                                      builder: (ctx) => Container(
                                        child: IconButton(
                                          icon: Icon(Icons.location_on),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10, height: 20,)
                      ],
                    )
                ),
              ),
              isLoading: model.busy
            ),
            floatingActionButton: FloatingActionButton(
              child: Text("Reset"),
              onPressed: (){
                model.DeleteList();
              },
            ),
          ),
      );
  }
}
