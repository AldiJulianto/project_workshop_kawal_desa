import 'package:flutter/cupertino.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0,);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0,);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0,);

const Widget verticalSpaceTiny = SizedBox(height: 5.0,);
const Widget verticalSpaceSmall = SizedBox(height: 10.0,);
const Widget verticalSpaceMedium = SizedBox(height: 25.0,);
const Widget verticalSpaceMassive = SizedBox(height: 50.0,);
const Widget verticalSpaceLarge = SizedBox(height: 120.0,);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.width;

double screenWidthPercent(BuildContext context, {double multipleBy = 1}) => (screenWidth(context) * multipleBy );
double screenHeightPercent(BuildContext context, {double multipleBy = 1}) => (screenWidth(context) * multipleBy);

