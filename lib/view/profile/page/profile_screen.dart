import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/profile_list_tile.dart';

import 'dart:developer';

import 'notifacton_page.dart';
import 'personal_informations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          child: Column(
            children: [
              header(context),
              profileHeader(context),
              Text(
                "Hari Bahadur Karki",
                style: TextStyle(
                    color: secondaryColors,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    fontSize: 0.017.toResponsive(context)),
              ),
              Text(
                "Waiter",
                style: TextStyle(
                    color: textColor,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    fontSize: 0.015.toResponsive(context)),
              ),
              SizedBox(
                height: 0.02.h(context),
              ),
              ProfileMenu(
                title: profileListTile[0]['name'],
                iconsImages: profileListTile[0]['imageName'],
                onPresed: () {
                  Get.to(() => const PersonalInfo());
                },
              ),
              ProfileMenu(
                title: profileListTile[1]['name'],
                iconsImages: profileListTile[1]['imageName'],
                onPresed: () {},
              ),
              ProfileMenu(
                title: profileListTile[2]['name'],
                iconsImages: profileListTile[2]['imageName'],
                onPresed: () {
                  Get.to(const Notifactions());
                },
              ),
              ProfileMenu(
                title: profileListTile[3]['name'],
                iconsImages: profileListTile[3]['imageName'],
                onPresed: () {},
              ),
              ProfileMenu(
                title: profileListTile[4]['name'],
                iconsImages: profileListTile[4]['imageName'],
                onPresed: () {},
              ),
              SizedBox(
                height: 0.02.h(context),
              ),
              fotter(context)
            ],
          )),
    ));
  }

  Center fotter(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 0.11.h(context),
            width: 1.0.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/brologo.png"))),
          ),
          Positioned(
            bottom: 0.001.h(context),
            left: 0.1.h(context),
            child: Text(
              "A Product of Brosoft Pvt. ltd",
              style: TextStyle(
                color: textColor,
                fontFamily: "Abhaya",
                fontWeight: FontWeight.w800,
                fontSize: 0.016.toResponsive(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox profileHeader(BuildContext context) {
    return SizedBox(
      height: 0.17.h(context),
      width: 1.0.w(context),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 0.7.h(context),
              width: 0.45.w(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/persion.png"))),
            ),
          ),
          Positioned(
              bottom: 0.030.toResponsive(context),
              right: 0.080.toResponsive(context),
              child: Container(
                  height: 0.07.h(context),
                  width: 0.15.w(context),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/editsicon.png")))))
        ],
      ),
    );
  }

  Row header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 0.05.w(context),
        ),
        Text(
          "Profile",
          style: TextStyle(
              color: textColor,
              fontFamily: "Nunito",
              fontSize: 0.017.toResponsive(context),
              fontWeight: FontWeight.w800),
        ),
        IconButton(
            onPressed: () {},
            icon: Image.asset("assets/images/notification.png"))
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.iconsImages,
    required this.onPresed,
  });

  final String title;
  final String iconsImages;
  final VoidCallback onPresed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPresed,
      child: Container(
        padding:
            EdgeInsetsDirectional.only(bottom: 0.010.toResponsive(context)),
        margin: EdgeInsetsDirectional.only(top: 0.007.toResponsive(context)),
        height: 0.07.h(context),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 0.1, color: secondaryColors)),
        child: ListTile(
          leading: Image.asset(iconsImages),
          title: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w800,
              fontSize: 0.016.toResponsive(context),
            ),
          ),
        ),
      ),
    );
  }
}
