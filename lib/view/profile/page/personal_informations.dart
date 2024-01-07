import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/profile/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custome_inputs_p.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String genderSelected = "male";
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileAppBar(
                  titleName: "Personal Information",
                  isNotifactions: true,
                  onPressed: () {
                    Get.back();
                  }),
              SizedBox(
                height: 0.09.h(context),
              ),
              Container(
                height: 0.7.h(context),
                width: 1.0.w(context),
                padding: EdgeInsets.symmetric(
                  horizontal: 0.014.toResponsive(context),
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.2, color: textColor),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Radiobuttonsfor Radio
                      radioForGender(context),

                      Text(
                        "Full Name*",
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: 0.022.h(context)),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),

                      CustomeInputsProfile(
                        hintText: "Hari Bahadur Karki",
                        height: 0.06.h(context),
                        width: 1.0.w(context),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //PhoneNumber

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PhoneNumber",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.022.h(context)),
                              ),
                              SizedBox(
                                height: 0.008.h(context),
                              ),
                              CustomeInputsProfile(
                                hintText: "9843111113",
                                height: 0.06.h(context),
                                width: 0.4.w(context),
                              ),
                            ],
                          ),

                          ///DateofBirths
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DateOfBirth",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.022.h(context)),
                              ),
                              SizedBox(
                                height: 0.008.h(context),
                              ),
                              CustomeInputsProfile(
                                hintText: "2076-05-45",
                                height: 0.06.h(context),
                                width: 0.4.w(context),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),
                      Text(
                        "Email*",
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: 0.022.h(context)),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),

                      CustomeInputsProfile(
                        hintText: "bibechhetr5678@gmail.com",
                        height: 0.06.h(context),
                        width: 1.0.w(context),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),

                      //startDate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //PhoneNumber

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date ",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.022.h(context)),
                              ),
                              SizedBox(
                                height: 0.008.h(context),
                              ),
                              CustomeInputsProfile(
                                hintText: "2076-05-14",
                                height: 0.06.h(context),
                                width: 0.4.w(context),
                              ),
                            ],
                          ),

                          ///DateofBirths
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Position*",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 0.022.h(context)),
                              ),
                              SizedBox(
                                height: 0.008.h(context),
                              ),
                              CustomeInputsProfile(
                                hintText: "Waiter",
                                height: 0.06.h(context),
                                width: 0.4.w(context),
                              ),
                            ],
                          )
                        ],
                      ),

                      SizedBox(
                        height: 0.015.h(context),
                      ),
                      Text(
                        "Address",
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: 0.022.h(context)),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),

                      CustomeInputsProfile(
                        hintText: "Sikles-4, vodetar pokhara",
                        height: 0.06.h(context),
                        width: 1.0.w(context),
                      ),
                      SizedBox(
                        height: 0.015.h(context),
                      ),
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }

  Row radioForGender(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              "Male",
              style: TextStyle(
                  fontSize: 0.017.toResponsive(context),
                  fontFamily: "Roboto",
                  color: textColor),
            ),
            Radio<String>(
              value: "male",
              groupValue: genderSelected,
              onChanged: (value) {
                setState(() {
                  genderSelected = value!;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "female",
              style: TextStyle(
                  fontSize: 0.017.toResponsive(context),
                  fontFamily: "Roboto",
                  color: textColor),
            ),
            Radio<String>(
              value: "female",
              groupValue: genderSelected,
              onChanged: (value) {
                setState(() {
                  genderSelected = value!;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
