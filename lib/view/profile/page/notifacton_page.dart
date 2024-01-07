import 'dart:developer';

import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';
import '../models/notifactions_models.dart';
import '../models/profile_list_tile.dart';
import '../widgets/profile_app_bar.dart';

class Notifactions extends StatefulWidget {
  const Notifactions({super.key});

  @override
  State<Notifactions> createState() => _NotifactionsState();
}

class _NotifactionsState extends State<Notifactions> {
  int indexBtnTap = 0;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAppBar(
                  titleName: "Notifactions",
                  onPressed: () {
                    Get.back();
                  }),
              SizedBox(
                height: 0.009.h(context),
              ),
              selectedBtns(context),
              SizedBox(
                height: 0.0135.h(context),
              ),
              Container(
                height: 0.8.h(context),
                width: 1.0.w(context),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: notifactionsDataList.length,
                    itemBuilder: (context, index) {
                      log('${notifactionsDataList.length}');
                      return Container(
                        height: 0.14.h(context),
                        width: 1.0.w(context),
                        margin: EdgeInsets.only(
                            top: index == 0 ? 0 : 0.010.toResponsive(context)),
                        decoration: BoxDecoration(
                            color: notifactionsDataList[index].nColors,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0.004.toResponsive(context),
                                  right: 0.007.toResponsive(context)),
                              child: Text(
                                notifactionsDataList[index].tableName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.012.toResponsive(context)),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.green,
                            height: 0.1.h(context),
                            child: Row(
                              children: [
                                //left

                                Container(
                                  height: 0.07.h(context),
                                  width: 0.2.w(context),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(82, 255, 255, 255),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              notifactionsDataList[index]
                                                  .niconsImages))),
                                ),

                                //right
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notifactionsDataList[index].nTitile,
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 0.015.toResponsive(context),
                                          color: primary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      notifactionsDataList[index].descriptions,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize:
                                              0.0135.toResponsive(context),
                                          color: primary,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container selectedBtns(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.00015.toResponsive(context)),
      padding: EdgeInsets.only(left: 0.00008.toResponsive(context)),
      height: 0.05.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: profilenotifactionBtnList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  indexBtnTap = index;
                });
              },
              child: Container(
                height: 0.8.h(context),
                width: 0.3.w(context),
                margin: EdgeInsets.only(left: index == 0 ? 0 : 7),
                decoration: BoxDecoration(
                    color: indexBtnTap == index ? secondaryColors : btnBghColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Text(
                  profilenotifactionBtnList[index],
                  style: myTextStyle(
                      indexBtnTap != index ? secondaryColors : primary,
                      0.0134.toResponsive(context),
                      " Roboto"),
                )),
              ),
            );
          }),
    );
  }
}
