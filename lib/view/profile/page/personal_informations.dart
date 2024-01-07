import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/profile/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

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
            ProfileAppBar(
                titleName: "Personal Information",
                isNotifactions: true,
                onPressed: () {
                  Get.back();
                })
          ],
        ),
      )),
    );
  }
}
