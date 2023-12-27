import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

showToast(
  BuildContext context,
  String toastText,
) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: textColor,
      content: Container(
        height: 0.05.h(context),
        width: 1.0.w(context),
        decoration: const BoxDecoration(
            color: textColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(
          toastText,
          style: myTextStyle(primary, 0.015.toResponsive(context), "Roboto"),
        ),
      ),
    ),
  );
}
