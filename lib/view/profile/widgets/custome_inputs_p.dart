import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class CustomeInputsProfile extends StatelessWidget {
  CustomeInputsProfile({
    super.key,
    required this.hintText,
    required this.height,
    required this.width,
  });

  final String hintText;
  final double height, width;

  bool obscureTextbool = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle:
              myTextStyle(textColor, 0.014.toResponsive(context), "Nunito"),
          focusColor: primary,
          hoverColor: primary,
          fillColor: primary,
          hintText: hintText,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: textColor, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: textColor, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: textColor, width: 1)),
        ),
      ),
    );
  }
}
