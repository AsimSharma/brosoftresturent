import 'package:brosoftresturent/model/tables_model.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';

import 'package:brosoftresturent/view/SelectedOrder/selected_order.dart';
import 'package:brosoftresturent/view/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/table_controller.dart';
import '../../../utils/app_style.dart';
import '../../../utils/random_number.dart';
import '../../widgets/custome_btns.dart';
import '../../widgets/custome_inputs.dart';
import '../models/btnmodels.dart';

import '../models/images.dart';
import 'dart:developer';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int btnTapIndex = 0;
  final tableController = Get.put(TableController());

  String searchValue = "";

  bool isReserved = false;

  List<TableModel> filterItems() {
    if (searchValue.isNotEmpty) {
      return tableController.tables
          .where((product) =>
              product.tabletype.toLowerCase().contains(searchValue))
          .toList();
    } else {
      if (btnTapIndex == 0) {
        return tableController.tables;
      } else {
        var selectedItem = btnlist[btnTapIndex];
        return tableController.tables
            .where((product) => selectedItem == product.tabletype)
            .toList();
      }
    }
  }

  @override
  void initState() {
    btnTapIndex = 0;
    tableController.getTables();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool reservedww = false;

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
        child: SingleChildScrollView(
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
              // llistedTableItems(context, filterTable)
              Obx(() => llistedTableItems(context, filterTable))
            ],
          ),
        ),
      ),
    );
  }

  SizedBox llistedTableItems(
      BuildContext context, List<TableModel> filterTable) {
    return SizedBox(
      height: 0.62.h(context),
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
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return bottomSheetNoReserved(
                                          context,
                                          tableItems.tableName,
                                          tableItems.seat,
                                          index1,
                                          index2,
                                          filterTable);
                                    });
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
    );
  }

  Container searchBar(BuildContext context) => Container(
        height: 0.065.h(context),
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
            SizedBox(
              height: 0.89.h(context),
              width: 0.7.w(context),
              child: Padding(
                padding: EdgeInsets.all(0.0037.toResponsive(context)),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search by table or category",
                    hintStyle: TextStyle(
                        color: textColor,
                        fontSize: 0.014.toResponsive(context),
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w900),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
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

  //nonReserved
  Container bottomSheetNoReserved(BuildContext context, String tableName,
      int numberGust, int index1, int index2, List<TableModel> filterTable) {
    var tableItems = filterTable[index1].tableItem[index2];
    var tablemodel = filterTable[index1];
    return Container(
      height: 0.63.h(context),
      width: 1.0.w(context),
      padding: EdgeInsets.only(
          left: 0.020.toResponsive(context),
          right: 0.020.toResponsive(context)),
      decoration: const BoxDecoration(
          color: btnBghColor,
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
                  tableController.noofseat = 0.obs;
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
                  Obx(
                    () => Text(
                      tableController.noofseat.toString(),
                      style: TextStyle(
                          color: secondaryColors,
                          fontSize: 0.017.toResponsive(context),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900),
                    ),
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
                                tableController.decreaseSeat(
                                  context,
                                );

                                // tableController.getTables();
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
                                tableController.increaseSeat(
                                    context, index1, index2);
                                // tableController.getTables();
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
                SizedBox(
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
                    btnTitle:
                        tableItems.reserved == true ? "UnReserved" : "Reserved",
                    onPressed: () {
                      tableController.changeReserved(tablemodel, tableItems);

                      Get.back();
                    },
                    color: tableItems.reserved == true
                        ? Colors.orange
                        : btnSecondaryColor,
                    width: 0.4.w(context),
                  ),
                  CustomBtn(
                    height: 1.0.h(context),
                    btnTitle: "Start",
                    onPressed: () {
                      Get.back();
                      tableController.noofseat > 0
                          ? showBottomSheet(
                              context: context,
                              builder: (context) {
                                return orderBottomSheet(context, tableName,
                                    tableController.noofseat.toInt());
                              })
                          : showToast(context, "guest cannot be Zero");
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

  Center orderBottomSheet(
    BuildContext context,
    String tableName,
    int totalGuest,
  ) {
    return Center(
      child: Container(
        height: 0.4.h(context),
        width: 1.0.toResponsive(context),
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            color: btnBghColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
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
                            image:
                                AssetImage("assets/images/cance_icons.png"))),
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
                            name: imageListcro[0]['name'] ?? "",
                            tableName: tableName,
                            totalGuest: totalGuest),
                        SizedBox(
                          width: 0.013.toResponsive(context),
                        ),
                        choseReletedContainer(context,
                            images: imageListcro[1]['imageName'] ?? "",
                            name: imageListcro[1]['name'] ?? "",
                            tableName: tableName,
                            totalGuest: totalGuest),
                      ],
                    ),
                    SizedBox(
                      height: 0.015.h(context),
                    ),
                    choseReletedContainer(context,
                        images: imageListcro[2]['imageName'] ?? "",
                        name: imageListcro[2]['name'] ?? "",
                        tableName: tableName,
                        totalGuest: totalGuest),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  InkWell choseReletedContainer(
    BuildContext context, {
    required String images,
    required String name,
    required String tableName,
    required int totalGuest,
  }) {
    return InkWell(
      onTap: () {
        Get.to(() => SelectedOrder(
            tablename: tableName,
            totalGuest: totalGuest,
            oderNo: getRandomnumber()));
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
