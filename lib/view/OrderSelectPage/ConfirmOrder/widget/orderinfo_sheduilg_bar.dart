import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_style.dart';

class OrderInfoshedulingBar extends StatelessWidget {
  const OrderInfoshedulingBar({
    super.key,
    required this.onTimePickUp,
  });

  final VoidCallback onTimePickUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.065.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Order Info",
            style: TextStyle(
                color: textColor,
                fontSize: 0.015.toResponsive(context),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w800),
          ),
          InkWell(
            onTap: onTimePickUp,
            child: Container(
              height: 0.8.h(context),
              width: 0.45.w(context),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black45, offset: Offset(0.0, 0.05)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Color.fromARGB(255, 245, 244, 244),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                    size: 25,
                  ),
                  Text(
                    "Schedule Order",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 0.015.toResponsive(context),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
