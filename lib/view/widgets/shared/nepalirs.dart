import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';

import 'package:flutter/material.dart';

class NepaliRSb extends StatelessWidget {
  const NepaliRSb(
      {super.key,
      this.textColors = Colors.black,
      this.fontWeight = FontWeight.w500,
      this.fontsSizes = 13,
      this.fontFamily = "Roboto"});
  final Color textColors;
  final FontWeight fontWeight;
  final double fontsSizes;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      "रु",
      style: TextStyle(
          color: textColor,
          fontSize: fontsSizes,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}

class NepaliRSw extends StatelessWidget {
  const NepaliRSw(
      {super.key,
      this.textColors = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.fontsSizes = 18,
      this.fontFamily = "Roboto"});
  final Color textColors;
  final FontWeight fontWeight;
  final double fontsSizes;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 0.004.toResponsive(context), right: 0.002.toResponsive(context)),
      child: Text(
        "रु",
        style: TextStyle(
            color: textColors,
            fontSize: fontsSizes,
            fontWeight: fontWeight,
            fontFamily: fontFamily),
      ),
    );
  }
}
