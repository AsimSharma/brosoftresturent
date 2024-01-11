import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';
import '../models/btnmodels.dart';

class CategoryselectedBtns extends StatelessWidget {
  const CategoryselectedBtns({
    super.key,
    required this.btnTapIndex,
    required this.index,
    required this.onPressed,
  });

  final int btnTapIndex;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 0.8.h(context),
        width: 0.27.w(context),
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: btnTapIndex == index ? secondaryColors : primary,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Center(
            child: Text(
          btnlist[index],
          style: myTextStyle(btnTapIndex != index ? secondaryColors : primary,
              0.0134.toResponsive(context), " Roboto"),
        )),
      ),
    );
  }
}
