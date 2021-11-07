import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
import 'package:project_workshop_kawal_desa/ui/shared/shared_style.dart';
import 'package:project_workshop_kawal_desa/ui/widgets/list_content_widget.dart';
//HomeViewModel dibuat setelah view
//import 'package:project_workshop_kawal_desa/viewmodels/report_view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/viewmodels/report_view_model.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/services.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key key}) : super (key:key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return ViewModelBuilder<ReportViewModel>.reactive(
        viewModelBuilder: () => ReportViewModel(),
        onModelReady: (model) => model.getAllReport(1),
        disposeViewModel: true,
        builder: (context, model, child) => Scaffold(
          appBar:  AppBar(
            title: Text(
              "Kawal Desa Aparat",
              style: TextStyle(fontFamily: 'meri'),
            ),
            backgroundColor: Colors.grey,
          ),
          backgroundColor: Color(0xffF3F6FF),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        print('refresh');
                        model.getAllReport(1);
                      },
                      child: Container(
                        color: Color(0xffF8F8FA),
                        child: Column(
                          children:<Widget> [
                            Expanded(
                              child: model.absenData.length != 0 ? NotificationListener<ScrollNotification>(
                                onNotification: (ScrollNotification scrollInfo){
                                  if(!model.isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                    model.pages += 1;
                                    model.loadMoreData(model.pages);
                                            }
                                      },
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      right: 8.0,
                                      left: 8.0
                                    ),
                                  itemCount: model.absenData.length,
                                  itemBuilder: (ctx, idx) => ListContentWidget(
                                      date: '${model.formatDate(model.absenData[idx].timestamp)}',
                                      address: '${model.absenData[idx].address}',
                                      content: '${model.absenData[idx].description}',
                                      imageUrl: '',
                                      name: '${model.absenData[idx].name}',
                                      imageLocal: '${model.absenData[idx].localImage}'
                                  ),
                                ),
                              ) : Center(
                                child: Text(
                                  'None'
                                ),
                              )
                            ),
                            Container(
                              height: model.isLoading ? 50.0 : 0,
                              color: Colors.transparent,
                              child: Center(
                                child: new CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          //Membuat tombol + untuk menammbah
          floatingActionButton: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.add,
                      color: Color(0xffF8F8FA),
                    ),
                    onPressed: (){
                      //model.goAnotherView(AbsenViewRoute);
                    },
                    heroTag: "AbsenViewRoute",
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
