import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class ResturantlogAppBar extends StatelessWidget {
  const ResturantlogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.015.h(context)),
      child: Container(
        color: primary,
        height: 0.1.h(context),
        width: 1.0.w(context),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 0.08.h(context),
                    width: 0.2.w(context),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/logo_images.png"))),
                  ),
                  SizedBox(
                    width: 0.0040.w(context),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        logoText,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 0.019.toResponsive(context),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 0.012.toResponsive(context),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 0.0030.w(context),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/notification.png"))
            ]),
      ),
    );
  }
}
