import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_workshop_kawal_desa/ui/shared/shared_style.dart';
import 'package:project_workshop_kawal_desa/ui/shared/ui_helper.dart';

class ButtonWidget extends StatelessWidget {


  final String title;
  final Function onPressedFunction;
  final Color bgColor;


  const ButtonWidget(
      {Key key, @required this.title, @required this.onPressedFunction, @required this.bgColor})
      : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: fieldPadding,
      width: screenWidthPercent(context, multipleBy: 0.9),
      child: RaisedButton(
        color: bgColor,
        onPressed: onPressedFunction,
        child: Text(
          '$title',
          style: textButtonTextStyle,
        ),
      ),
    );
  }
}
