import 'dart:io';

//Menginstall libary terlebih dahulu
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:flutter/material.dart';

class ListContentWidget extends StatelessWidget {
  const ListContentWidget({
    Key key,
    @required this.date,
    @required this.address,
    @required this.content,
    @required this.imageUrl,
    @required this.name,
    @required this.imageLocal,
    this.detailFunction,
    this.img=false,
    this.send
}) : super (key: key);

  final String send;
  final String date;
  final String content;
  final String address;
  final String name;
  final String imageUrl;
  final String imageLocal;
  final Function detailFunction;
  final bool img;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 250,
      child: Row(
        children:<Widget> [
          InkWell(
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: img==true?FileImage(File(imageLocal)):NetworkImage(imageUrl),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:  10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  Row(
                    children:<Widget> [
                      Expanded(
                          child: Text(
                            "$date",
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                            ),
                          ),
                        flex: 2,
                      ),
                      Container(
                        width: 50,
                        child: IconButton(
                          onPressed: (){
                            detailFunction;
                          },
                          color: Color(000000),
                          icon: null,
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Text(
                      "$content",
                      style: TextStyle(color: null),
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    child: Text(
                      "$address",
                      style: TextStyle(color: null),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Text(
                    "$name",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.orange),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    //FAICON diambil dari librari FontAwesomeIcons
                    child: (send=='pending')
                            ?FaIcon(FontAwesomeIcons.clock, size: 15, color: Colors.grey)
                            :FaIcon(FontAwesomeIcons.check, size:15, color: Colors.grey)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
