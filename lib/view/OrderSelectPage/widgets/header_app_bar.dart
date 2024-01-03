import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';

class HeadeAppBar extends StatelessWidget {
  const HeadeAppBar({
    super.key,
    required this.titleName,
  });

  final String titleName;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(top: 0.001.toResponsive(context)),
      color: primary,
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 0.05.h(context),
              width: 0.03.w(context),
              child: Container(
                height: 0.025.h(context),
                width: 0.02.w(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Back Icon.png"))),
              ),
            ),
          ),
          Text(
            titleName,
            style: TextStyle(
                color: textColor,
                fontSize: 0.015.toResponsive(context),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w900),
          ),
          Container(
            height: 0.06.h(context),
            width: 0.06.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/notification.png"))),
          ),
        ],
      ),
    );
  }
}
