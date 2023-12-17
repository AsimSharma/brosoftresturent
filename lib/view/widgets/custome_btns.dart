import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/app_style.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.btnTitle,
      required this.onPressed,
      this.width = 300,
      this.height = 45});

  final String btnTitle;
  final VoidCallback onPressed;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            color: btnPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
            child: Text(
          btnTitle,
          style: myTextStyle(primary, 0.001.toResponsive(context), 'Roboto'),
        )),
      ),
    );
  }
}
