import 'package:brosoftresturent/controller/table_controller.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/widgets/custome_inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import '../widgets/custome_btns.dart';
import 'models/btnModels.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int btnTapIndex = 0;
  final tableController = Get.put(TableController());
  @override
  void initState() {
    tableController.getTables();
    super.initState();
  }

  bool isReserved = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(children: [
                logoHeader(context),
                searchBar(context),
                //
                const SizedBox(
                  height: 15,
                ),
                selectedBtn(context),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Ground Floor",
                    style: myTextStyle(
                        textColor, 0.013.toResponsive(context), "Roboto"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //gridContainer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 350,
                  width: 1.0.w(context),
                  child: Stack(
                    children: [
                      GridView.builder(
                          itemCount: tableController.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    isReserved == false
                                        ? bottomSheetReserved(
                                            context,
                                            tableController
                                                .products[index].tableName,
                                            tableController
                                                .products[index].number)
                                        : bottomSheetNoReserved(
                                            context,
                                            tableController
                                                .products[index].tableName,
                                            tableController
                                                .products[index].number,
                                            index),
                                  );
                                },
                                child: Card(
                                  color: tableController
                                              .products[index].reserved ==
                                          true
                                      ? reservedColor
                                      : primary,
                                  child: tableController.products.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: secondaryColors,
                                            backgroundColor: reservedColor,
                                          ),
                                        )
                                      : Stack(children: [
                                          Positioned(
                                            top: 10,
                                            left: 20,
                                            child: Container(
                                              child: Text(tableController
                                                  .products[index].tableName),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            height: 20,
                                            left: 10,
                                            width: 1.0.w(context),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  height: 25,
                                                  width: 25,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/imageperson.png"))),
                                                ),
                                                Text(
                                                    "${tableController.products[index].number.toString()} people"),
                                              ],
                                            ),
                                          ),
                                        ]),
                                ),
                              )),
                    ],
                  ),
                )
              ]))),
    ));
  }

  Container bottomSheetReserved(
      BuildContext context, String tableNumber, num numberGust) {
    return Container(
      height: 0.4.h(context),
      width: 1.0.toResponsive(context),
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40))),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/cance_icons.png"))),
            ),
          ),
        ),

        Row(
          children: [
            Text(
              "Table",
              style: myTextStyle(
                  textColor, 0.018.toResponsive(context), "RobotoRegular"),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              tableNumber,
              style: myTextStyle(secondaryColors, 0.018.toResponsive(context),
                  "RobotoRegular"),
            ),
          ],
        ),

        SizedBox(
          height: 0.05.h(context),
          width: 1.0.w(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "No of Guests:",
                style: myTextStyle(
                    textColor, 0.017.toResponsive(context), "RobotoRegular"),
              ),
              Text(
                numberGust.toString(),
                style: myTextStyle(secondaryColors, 0.015.toResponsive(context),
                    "RobotoRegular"),
              ),

              //btnContainer
              Container(
                height: 35,
                width: 150,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 207, 218, 226),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(child: Image.asset("assets/images/Add icon.png")),
                      const VerticalDivider(
                        color: textColor,
                        width: 10,
                      ),
                      InkWell(
                          child: Image.asset("assets/images/subtract icon.png"))
                    ]),
              ),
            ],
          ),
        ),
        20.height,
        //btns
        Row(
          children: [
            CustomBtn(
              btnTitle: "Reserved",
              onPressed: () {},
              color: btnSecondaryColor,
              width: 0.4.w(context),
            ),
            18.0.width,
            CustomBtn(
              btnTitle: "Start",
              onPressed: () {},
              width: 0.44.w(context),
            )
          ],
        )
      ]),
    );
  }

  Container bottomSheetNoReserved(
      BuildContext context, String tableNumber, num numberGust, int index) {
    return Container(
      height: 0.8.h(context),
      width: 1.0.toResponsive(context),
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/cance_icons.png"))),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Table",
                style: myTextStyle(
                    textColor, 0.018.toResponsive(context), "RobotoRegular"),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                tableNumber,
                style: myTextStyle(secondaryColors, 0.018.toResponsive(context),
                    "RobotoRegular"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 0.05.h(context),
            width: 1.0.w(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No of Guests:",
                  style: myTextStyle(
                      textColor, 0.018.toResponsive(context), "RobotoRegular"),
                ),
                Text(
                  numberGust.toString(),
                  style: myTextStyle(secondaryColors,
                      0.017.toResponsive(context), "RobotoRegular"),
                ),
                6.width,
                //btnContainer
                Container(
                  height: 35,
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 207, 218, 226),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              log("increment");

                              // tableController.incrementNumber(index);
                              setState(() {
                                numberGust = numberGust++;
                              });
                            },
                            child: Image.asset("assets/images/Add icon.png")),
                        const VerticalDivider(
                          color: textColor,
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              log("decrement");
                              // tableController.decRementNumber(index);
                              setState(() {
                                numberGust = numberGust--;
                              });
                            },
                            child:
                                Image.asset("assets/images/subtract icon.png"))
                      ]),
                ),
              ],
            ),
          ),
          8.height,
          const Divider(
            // height: 52,
            color: secondaryColors,
            thickness: 2.0,
          ),

          //GeustPersinolinfo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Guest Personal Info:",
                style: myTextStyle(
                    textColor, 0.014.toResponsive(context), "RobotoRegular"),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/vector.png"))),
              ),
            ],
          ),
          10.height,
          //Inputs
          Container(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: 50,
                width: 1.0.w(context),
                child: const CustomeInputs(
                    hintText: "Name", textinputTypes: TextInputType.text),
              ),
              10.height,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                height: 50,
                width: 1.0.w(context),
                child: const CustomeInputs(
                    hintText: "Number", textinputTypes: TextInputType.text),
              ),
              10.height,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                height: 50,
                width: 1.0.w(context),
                child: const CustomeInputs(
                    hintText: "Customer No",
                    textinputTypes: TextInputType.text),
              ),
            ]),
          ),

          20.height,
          //btns
          Row(
            children: [
              CustomBtn(
                btnTitle: "Reserved",
                onPressed: () {},
                color: btnSecondaryColor,
                width: 0.4.w(context),
              ),
              18.0.width,
              CustomBtn(
                btnTitle: "Start",
                onPressed: () {
                  log("hello from non Reserved");
                },
                width: 0.44.w(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Container selectedBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      width: 0.1.w(context),
      child: Row(
        children: [
          ...List.generate(
              btnlist.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        btnTapIndex = index;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color:
                              btnTapIndex == index ? secondaryColors : primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Center(
                          child: Text(
                        btnlist[index],
                        style: myTextStyle(
                            btnTapIndex != index ? secondaryColors : primary,
                            0.008.toResponsive(context),
                            " Roboto"),
                      )),
                    ),
                  ))
        ],
      ),
    );
  }

  Container searchBar(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 0.06.h(context),
        width: 1.0.w(context),
        decoration: BoxDecoration(
            // color: Colors.red,
            boxShadow: const [
              BoxShadow(
                  color: primary,
                  offset: Offset(0.0, 0.1),
                  blurRadius: 0.5,
                  spreadRadius: 0.5)
            ],
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 100,
            width: 0.2.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/searchicons.png"))),
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              width: 0.7.w(context),
              child: const CustomeInputs(
                  hintText: "search by table or caterozie",
                  textinputTypes: TextInputType.text),
            ),
          )
        ]),
      );

  Container logoHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: primary,
      height: 0.15.h(context),
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
                          textColor, 0.018.toResponsive(context), "Roboto"),
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
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/notification.png"))
          ]),
    );
  }
}
