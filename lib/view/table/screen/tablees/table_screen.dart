import 'package:brosoftresturent/model/tables_model.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';

import 'package:brosoftresturent/view/table/screen/SelectedOrder/selected_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/table_controller.dart';
import '../../../../utils/app_style.dart';
import '../../../widgets/custome_btns.dart';
import '../../../widgets/custome_inputs.dart';
import '../../models/btnmodels.dart';

import '../../models/images.dart';

import 'dart:developer';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int btnTapIndex = 0;

  final tableComtroller = Get.put(TableController());

  List<TableModel> filterItems() {
    if (btnTapIndex == 0) {
      return tableComtroller.tables;
    } else {
      var selectedItem = btnlist[btnTapIndex];
      return tableComtroller.tables
          .where((product) => selectedItem == product.tabletype)
          .toList();
    }
  }

  @override
  void initState() {
    btnTapIndex = 0;
    tableComtroller.getTables();
    super.initState();
  }

  // bool reserved = false;
  int addGuests = 0;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final customernoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var filterTable = filterItems();

    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 0.01.toResponsive(context),
          right: 0.01.toResponsive(context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 0.025.h(context),
            ),
            SingleChildScrollView(child: logoHeader(context)),
            SizedBox(
              height: 0.015.h(context),
            ),
            searchBar(context),
            SizedBox(
              height: 0.015.h(context),
            ),
            selectedBtn(context),
            SizedBox(
              height: 0.015.h(context),
            ),
            //tableItems
            Obx(() => tableComtroller.isLooding == true.obs
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : llistedTableItems(context, filterTable))
          ],
        ),
      ),
    );
  }

  Container llistedTableItems(
      BuildContext context, List<TableModel> filterTable) {
    return Container(
      height: 0.63.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          itemCount: filterTable.length,
          itemBuilder: (context, index1) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filterTable[index1].tabletype,
                    style: myTextStyle(
                        secondaryColors, 0.015.toResponsive(context), "Roboto"),
                  ),
                  SizedBox(
                    height: 0.001.w(context),
                  ),
                  SizedBox(
                      // color: Colors.red,
                      height: 0.5.h(context),
                      width: 1.0.w(context),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: filterTable[index1].tableItem.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index2) {
                            var tableItems =
                                filterTable[index1].tableItem[index2];
                            return GestureDetector(
                              onTap: () {
                                Get.bottomSheet(bottomSheetNoReserved(
                                    context,
                                    tableItems.tableName,
                                    tableItems.seat,
                                    tableItems.reserved));
                              },
                              child: Card(
                                color: tableItems.reserved == true
                                    ? reservedColor
                                    : primary,
                                margin: EdgeInsets.all(
                                    0.0051.toResponsive(context)),
                                child: Stack(children: [
                                  Positioned(
                                      top: 0.010.h(context),
                                      right: 0.02.h(context),
                                      child: Text(
                                        tableItems.tableName,
                                        style: TextStyle(
                                            color: secondaryColors,
                                            fontSize:
                                                0.017.toResponsive(context),
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "Roboto"),
                                      )),
                                  Positioned(
                                    bottom: 0.01.h(context),
                                    child: Row(children: [
                                      Container(
                                        height: 0.03.w(context),
                                        width: 0.05.w(context),
                                        child: Image.asset(
                                          "assets/images/imageperson.png",
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${tableItems.seat} ",
                                            style: myTextStyle(
                                                secondaryColors,
                                                0.015.toResponsive(context),
                                                "Roboto"),
                                          ),
                                          Text(
                                            "people",
                                            style: myTextStyle(
                                                textColor,
                                                0.011.toResponsive(context),
                                                "Nunito"),
                                          )
                                        ],
                                      )
                                    ]),
                                  ),
                                ]),
                              ),
                            );
                          }))
                ],
              )),
    );
  }

  Container logoHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.01.toResponsive(context)),
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

  Container searchBar(BuildContext context) => Container(
        height: 0.06.h(context),
        width: 1.0.w(context),
        margin: EdgeInsets.only(left: 0.0055.toResponsive(context)),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.2,
            style: BorderStyle.solid,
            color: textColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 0.06.h(context),
              width: 0.2.w(context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/searchicons.png"),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by table or category",
                  hintStyle: myTextStyle(
                      textColor, 0.015.toResponsive(context), "Roboto"),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      );

  Container selectedBtn(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      padding: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      height: 0.05.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: btnlist.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  btnTapIndex = index;
                });
              },
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
                  style: myTextStyle(
                      btnTapIndex != index ? secondaryColors : primary,
                      0.0134.toResponsive(context),
                      " Roboto"),
                )),
              ),
            );
          }),
    );
  }

//bottomSheetReserved
  Container bottomSheetReserved(
      BuildContext context, String tableNumber, num numberGust) {
    return Container(
      height: 0.4.h(context),
      width: 1.0.toResponsive(context),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40))),
      child: Column(children: [
        SizedBox(
          height: 0.03.h(context),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 0.04.h(context),
              width: 0.1.w(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/cance_icons.png"))),
            ),
          ),
        ),
        SizedBox(
          height: 0.03.h(context),
        ),
        Row(
          children: [
            Text(
              "Table",
              style: myTextStyle(
                  textColor, 0.018.toResponsive(context), "RobotoRegular"),
            ),
            SizedBox(
              width: 0.005.w(context),
            ),
            Text(
              tableNumber,
              style: TextStyle(
                  color: secondaryColors,
                  fontSize: 0.017.toResponsive(context),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        SizedBox(
          height: 0.03.h(context),
        ),
        Container(
          padding: EdgeInsets.all(0.005.toResponsive(context)),
          height: 0.07.h(context),
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
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.017.toResponsive(context),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
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

        SizedBox(
          height: 0.04.h(context),
        ),
        //btns
        Container(
          height: 0.08.h(context),
          width: 1.0.w(context),
          padding: EdgeInsets.all(0.005.toResponsive(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBtn(
                btnTitle: "Reserved",
                onPressed: () {},
                color: btnSecondaryColor,
                width: 0.4.w(context),
              ),
              CustomBtn(
                btnTitle: "Start",
                onPressed: () {},
                width: 0.44.w(context),
              )
            ],
          ),
        )
      ]),
    );
  }

  //nonReserved
  Container bottomSheetNoReserved(
      BuildContext context, String tableName, int numberGust, bool reserved) {
    return Container(
      height: 2.0.h(context),
      width: 1.0.w(context),
      padding: EdgeInsets.only(
          left: 0.020.toResponsive(context),
          right: 0.020.toResponsive(context)),
      decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.035.h(context),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 0.06.h(context),
                  width: 0.03.h(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cance_icons.png"))),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Table   ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.015.toResponsive(context),
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 0.005.w(context),
                ),
                Text(
                  tableName,
                  style: TextStyle(
                      color: secondaryColors,
                      fontSize: 0.017.toResponsive(context),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),

            Container(
              // color: Colors.red,
              height: 0.08.h(context),
              width: 1.0.w(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No of Guests:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.015.toResponsive(context),
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800),
                  ),

                  Text(
                    addGuests.toString(),
                    style: TextStyle(
                        color: secondaryColors,
                        fontSize: 0.017.toResponsive(context),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900),
                  ),

                  //btnContainer
                  Container(
                    height: 0.055.h(context),
                    width: 0.35.w(context),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 207, 218, 226),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  addGuests = addGuests - 1;
                                  log(addGuests.toString());
                                });
                              },
                              child: SizedBox(
                                height: 0.2.h(context),
                                width: 0.1.w(context),
                                child: Image.asset(
                                    "assets/images/subtract icon.png"),
                              )),
                          const VerticalDivider(
                            color: textColor,
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  addGuests = addGuests + 1;
                                  log(addGuests.toString());
                                });
                              },
                              child: SizedBox(
                                  height: 0.2.h(context),
                                  width: 0.1.w(context),
                                  child: Image.asset(
                                      "assets/images/Add icon.png"))),
                        ]),
                  ),
                ],
              ),
            ),

            const Divider(
              color: secondaryColors,
              thickness: 2.0,
            ),

            //GeustPersinolinfo
            Container(
              height: 0.065.h(context),
              width: 1.0.w(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Guest Personal Info:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 0.015.toResponsive(context),
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: 0.31.h(context),
                    width: 0.071.w(context),
                    decoration: const BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage("assets/images/Barcode.png"))),
                  ),
                ],
              ),
            ),

            //Inputs
            Form(
              child: Column(children: [
                Container(
                  height: 0.07.h(context),
                  width: 1.0.w(context),
                  child: CustomeInputs(
                      textEditingController: nameController,
                      hintText: "Name",
                      textinputTypes: TextInputType.text),
                ),
                SizedBox(
                  height: 0.01.h(context),
                ),
                SizedBox(
                  height: 0.07.h(context),
                  width: 1.0.w(context),
                  child: CustomeInputs(
                      textEditingController: numberController,
                      hintText: "Number",
                      textinputTypes: TextInputType.number),
                ),
                SizedBox(
                  height: 0.01.h(context),
                ),
                SizedBox(
                  height: 0.07.h(context),
                  width: 1.0.w(context),
                  child: CustomeInputs(
                      textEditingController: customernoController,
                      hintText: "Customer No",
                      textinputTypes: TextInputType.number),
                ),
              ]),
            ),
            SizedBox(
              height: 0.02.h(context),
            ),
            //btns
            SizedBox(
              height: 0.058.h(context),
              width: 1.0.w(context),

              // padding: EdgeInsets.all(0.005.toResponsive(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBtn(
                    height: 0.5.h(context),
                    btnTitle: "Reserved",
                    onPressed: () {
                      setState(() {
                        reserved = !reserved;
                        log(reserved.toString());
                      });
                    },
                    color: btnSecondaryColor,
                    width: 0.4.w(context),
                  ),
                  CustomBtn(
                    height: 1.0.h(context),
                    btnTitle: "Start",
                    onPressed: () {
                      Get.back();
                      Get.bottomSheet(orderBottomSheet(context));
                    },
                    width: 0.44.w(context),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.h(context),
            ),
          ],
        ),
      ),
    );
  }

  Container orderBottomSheet(BuildContext context) {
    return Container(
      height: 0.4.h(context),
      width: 1.0.toResponsive(context),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
          color: primary, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Related Order",
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.017.toResponsive(context),
                    fontWeight: FontWeight.w800,
                    fontFamily: "Nunito"),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 0.060.h(context),
                  width: 0.060.w(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cance_icons.png"))),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 1.0.w(context),
            height: 0.55.w(context),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      choseReletedContainer(context,
                          images: imageListcro[0]['imageName'] ?? "",
                          name: imageListcro[0]['name'] ?? ""),
                      SizedBox(
                        width: 0.013.toResponsive(context),
                      ),
                      choseReletedContainer(context,
                          images: imageListcro[1]['imageName'] ?? "",
                          name: imageListcro[1]['name'] ?? ""),
                    ],
                  ),
                  SizedBox(
                    height: 0.015.h(context),
                  ),
                  choseReletedContainer(context,
                      images: imageListcro[2]['imageName'] ?? "",
                      name: imageListcro[2]['name'] ?? ""),
                ]),
          )
        ],
      ),
    );
  }

  InkWell choseReletedContainer(
    BuildContext context, {
    required String images,
    required String name,
  }) {
    return InkWell(
      onTap: () {
        Get.to(const SelectedOrder());
      },
      child: Container(
        height: 0.1.h(context),
        width: 0.35.w(context),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1, color: secondaryColors)),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset(images),
              Text(
                name,
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.017.toResponsive(context),
                    fontWeight: FontWeight.w800,
                    fontFamily: "Nunito"),
              )
            ])),
      ),
    );
  }
}