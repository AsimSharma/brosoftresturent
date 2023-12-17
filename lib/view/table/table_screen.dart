import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    children: [logoHeader(context), searchBar(context)]))));
  }

  Container searchBar(BuildContext context) => Container(
        height: 0.05.h(context),
        decoration: const BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Row(children: [
          Container(
            height: 1.0.h(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo_images.png"))),
          ),
        ]),
      );

  Container logoHeader(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      color: primary,
      height: 0.15.h(context),
      width: 1.0.w(context),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 0.2.h(context),
              width: 0.2.w(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo_images.png"))),
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
                  style: myTextStyle(
                      textColor, 0.017.toResponsive(context), "Roboto"),
                ),
                Text(
                  address,
                  style: myTextStyle(
                      textColor, 0.011.toResponsive(context), "Roboto"),
                )
              ],
            ),
            SizedBox(
              width: 0.0030.w(context),
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/notification.png"))
          ]),
    );
  }
}
