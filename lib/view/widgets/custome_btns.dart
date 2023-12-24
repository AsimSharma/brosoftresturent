import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/app_style.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.btnTitle,
    required this.onPressed,
    this.width = 100,
    this.height = 45,
    this.color = btnPrimaryColor,
  });

  final String btnTitle;
  final VoidCallback onPressed;
  final double width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Center(
            child: Text(
          btnTitle,
          style: TextStyle(
              color: primary,
              fontSize: 0.015.toResponsive(context),
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
