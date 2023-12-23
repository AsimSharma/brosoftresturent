// import 'package:brosoftresturent/controller/table_controller.dart';
// import 'package:brosoftresturent/model/guest_userInfo.dart';
// import 'package:brosoftresturent/utils/app_style.dart';
// import 'package:brosoftresturent/utils/responsive_extension.dart';
// import 'package:brosoftresturent/view/widgets/custome_inputs.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:developer';

// import '../widgets/custome_btns.dart';
// import 'models/btnModels.dart';
// import 'models/releted_orderbtn.dart';

// class TableScreen extends StatefulWidget {
//   const TableScreen({super.key});

//   @override
//   State<TableScreen> createState() => _TableScreenState();
// }

// class _TableScreenState extends State<TableScreen> {
//   int btnTapIndex = 0;
//   final tableController = Get.put(TableController());
//   @override
//   void initState() {
//     tableController.getTables();
//     super.initState();
//   }

//   bool isReserved = true;

//   final nameController = TextEditingController();
//   final numberController = TextEditingController();
//   final customerNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Obx(
//           () => ListView(children: [
//             logoHeader(context),
//             searchBar(context),
//             //
//             const SizedBox(
//               height: 15,
//             ),
//             selectedBtn(context),
//             const SizedBox(
//               height: 15,
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Text(
//                 "Ground Floor",
//                 style: myTextStyle(
//                     textColor, 0.013.toResponsive(context), "Roboto"),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),

//             //gridContainer
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               height: 350,
//               width: 1.0.w(context),
//               child: Stack(
//                 children: [
//                   GridView.builder(
//                       itemCount: tableController.products.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3),
//                       itemBuilder: (context, index) => InkWell(
//                             onTap: () {
//                               Get.bottomSheet(
//                                 isReserved == false
//                                     ? bottomSheetReserved(
//                                         context,
//                                         tableController
//                                             .products[index].tableName,
//                                         tableController
//                                             .products[index].noOfGuest)
//                                     : bottomSheetNoReserved(
//                                         context,
//                                         tableController
//                                             .products[index].tableName,
//                                         tableController
//                                             .products[index].noOfGuest,
//                                         index),
//                               );
//                             },
//                             child: Card(
//                               color: tableController.products[index].reserved ==
//                                       true
//                                   ? reservedColor
//                                   : primary,
//                               child: tableController.products.length == 0
//                                   ? const Center(
//                                       child: CircularProgressIndicator(
//                                         color: secondaryColors,
//                                         backgroundColor: reservedColor,
//                                       ),
//                                     )
//                                   : Stack(children: [
//                                       Positioned(
//                                         top: 10,
//                                         child: Container(
//                                           child: Text(tableController
//                                               .products[index].tableName),
//                                         ),
//                                       ),
//                                       Positioned(
//                                           bottom: 5,
//                                           child: Container(
//                                             height: 0.05.h(context),
//                                             width: 1.0.w(context),
//                                             child: Row(children: [
//                                               Container(
//                                                 height: 100,
//                                                 width: 0.08.w(context),
//                                                 decoration: const BoxDecoration(
//                                                     image: DecorationImage(
//                                                         image: AssetImage(
//                                                             "assets/images/imageperson.png"))),
//                                               ),
//                                               Text(
//                                                   "${tableController.products[index].noOfGuest} people")
//                                             ]),
//                                           ))
//                                     ]),
//                             ),
//                           )),
//                 ],
//               ),
//             )
//           ]),
//         ),
//       ),
//     ));
//   }

//   Container bottomSheetReserved(
//       BuildContext context, String tableNumber, num numberGust) {
//     return Container(
//       height: 0.4.h(context),
//       width: 1.0.toResponsive(context),
//       padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
//       decoration: const BoxDecoration(
//           color: primary,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(40), topLeft: Radius.circular(40))),
//       child:
//           Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/images/cance_icons.png"))),
//             ),
//           ),
//         ),

//         Row(
//           children: [
//             Text(
//               "Table",
//               style: myTextStyle(
//                   textColor, 0.018.toResponsive(context), "RobotoRegular"),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               tableNumber,
//               style: myTextStyle(secondaryColors, 0.018.toResponsive(context),
//                   "RobotoRegular"),
//             ),
//           ],
//         ),

//         SizedBox(
//           height: 0.05.h(context),
//           width: 1.0.w(context),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "No of Guests:",
//                 style: myTextStyle(
//                     textColor, 0.017.toResponsive(context), "RobotoRegular"),
//               ),
//               Text(
//                 numberGust.toString(),
//                 style: myTextStyle(secondaryColors, 0.015.toResponsive(context),
//                     "RobotoRegular"),
//               ),

//               //btnContainer
//               Container(
//                 height: 35,
//                 width: 150,
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 207, 218, 226),
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(child: Image.asset("assets/images/Add icon.png")),
//                       const VerticalDivider(
//                         color: textColor,
//                         width: 10,
//                       ),
//                       InkWell(
//                           child: Image.asset("assets/images/subtract icon.png"))
//                     ]),
//               ),
//             ],
//           ),
//         ),
//         20.height,
//         //btns
//         Row(
//           children: [
//             CustomBtn(
//               btnTitle: "Reserved",
//               onPressed: () {},
//               color: btnSecondaryColor,
//               width: 0.4.w(context),
//             ),
//             18.0.width,
//             CustomBtn(
//               btnTitle: "Start",
//               onPressed: () {},
//               width: 0.44.w(context),
//             )
//           ],
//         )
//       ]),
//     );
//   }

//   Container bottomSheetNoReserved(
//       BuildContext context, String tableNumber, num numberGust, int index) {
//     return Container(
//       height: 0.9.h(context),
//       width: 1.0.toResponsive(context),
//       padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
//       decoration: const BoxDecoration(
//           color: primary,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(40), topLeft: Radius.circular(40))),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 0.005.h(context),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 height: 0.03.h(context),
//                 width: 0.03.h(context),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/cance_icons.png"))),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Text(
//                 "Table",
//                 style: myTextStyle(
//                     textColor, 0.015.toResponsive(context), "RobotoRegular"),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 tableNumber,
//                 style: myTextStyle(secondaryColors, 0.015.toResponsive(context),
//                     "RobotoRegular"),
//               ),
//             ],
//           ),

//           SizedBox(
//             height: 0.05.h(context),
//             width: 1.0.w(context),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "No of Guests:",
//                   style: myTextStyle(
//                       textColor, 0.013.toResponsive(context), "RobotoRegular"),
//                 ),
//                 Text(
//                   numberGust.toString(),
//                   style: myTextStyle(secondaryColors,
//                       0.013.toResponsive(context), "RobotoRegular"),
//                 ),

//                 //btnContainer
//                 Container(
//                   height: 0.035.h(context),
//                   width: 0.35.w(context),
//                   padding: const EdgeInsets.all(10),
//                   decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 207, 218, 226),
//                       borderRadius: BorderRadius.all(Radius.circular(15))),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                             onTap: () {
//                               log("increment");
//                             },
//                             child: Expanded(
//                                 child:
//                                     Image.asset("assets/images/Add icon.png"))),
//                         const VerticalDivider(
//                           color: textColor,
//                           width: 10,
//                         ),
//                         InkWell(
//                             onTap: () {},
//                             child: Expanded(
//                                 child: Image.asset(
//                                     "assets/images/subtract icon.png")))
//                       ]),
//                 ),
//               ],
//             ),
//           ),

//           const Divider(
//             // height: 52,
//             color: secondaryColors,
//             thickness: 2.0,
//           ),

//           //GeustPersinolinfo
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Guest Personal Info:",
//                 style: myTextStyle(
//                     textColor, 0.014.toResponsive(context), "RobotoRegular"),
//               ),
//               Container(
//                 height: 0.050.h(context),
//                 width: 0.050.w(context),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/Barcode.png"))),
//               ),
//             ],
//           ),

//           //Inputs
//           Container(
//             child: Column(children: [
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 2.0),
//                     borderRadius: const BorderRadius.all(Radius.circular(10))),
//                 height: 0.050.h(context),
//                 width: 1.0.w(context),
//                 child: CustomeInputs(
//                     textEditingController: nameController,
//                     hintText: "Name",
//                     textinputTypes: TextInputType.text),
//               ),
//               SizedBox(
//                 height: 0.015.h(context),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: const BorderRadius.all(Radius.circular(40))),
//                 height: 0.05.h(context),
//                 width: 1.0.w(context),
//                 child: CustomeInputs(
//                     textEditingController: numberController,
//                     hintText: "Number",
//                     textinputTypes: TextInputType.number),
//               ),
//               SizedBox(
//                 height: 0.015.h(context),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: const BorderRadius.all(Radius.circular(40))),
//                 height: 0.05.h(context),
//                 width: 1.0.w(context),
//                 child: CustomeInputs(
//                     textEditingController: customerNumberController,
//                     hintText: "Customer No",
//                     textinputTypes: TextInputType.number),
//               ),
//             ]),
//           ),
//           SizedBox(
//             height: 0.025.h(context),
//           ),

//           //btns
//           Row(
//             children: [
//               CustomBtn(
//                 btnTitle: "Reserved",
//                 onPressed: () {
//                   Get.back();
//                   Get.bottomSheet(orderBottomSheet(context));
//                 },
//                 color: btnSecondaryColor,
//                 width: 0.4.w(context),
//               ),
//               18.0.width,
//               CustomBtn(
//                 btnTitle: "Start",
//                 onPressed: () {
//                   log("hello from non Reserved");

//                   tableController.postGuestInfo(
//                       guestModel: GuestModel(
//                           noOfGuest: 10,
//                           number: 25,
//                           customerNumber: 351,
//                           id: "1",
//                           name: "heloooo"));
//                 },
//                 width: 0.44.w(context),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Center orderBottomSheet(BuildContext context) {
//     return Center(
//       child: Container(
//         height: 0.4.h(context),
//         width: 1.0.toResponsive(context),
//         padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
//         decoration: const BoxDecoration(
//             color: primary,
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Choose Related Order",
//                   style: myTextStyle(
//                       secondaryColors, 0.015.toResponsive(context), "Roboto"),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image:
//                                 AssetImage("assets/images/cance_icons.png"))),
//                   ),
//                 ),
//               ],
//             ),

//             //choose Related order

//             ...List.generate(
//                 3,
//                 (index) => Row(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(12)),
//                               border: Border.all(
//                                   color: secondaryColors, width: 1.0)),
//                           child: Column(
//                             // mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 50,
//                                 width: 50,
//                                 decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage(
//                                             "assets/images/order_dark.png"))),
//                               ),
//                               Text(
//                                 reletedOrderMode[index].name,
//                                 style: myTextStyle(secondaryColors,
//                                     0.015.toResponsive(context), "Roboto"),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ))
//           ],
//         ),
//       ),
//     );
//   }

//   Container selectedBtn(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       height: 30,
//       width: 0.8.w(context),
//       child: Row(
//         children: [
//           ...List.generate(
//               btnlist.length,
//               (index) => InkWell(
//                     onTap: () {
//                       setState(() {
//                         btnTapIndex = index;
//                       });
//                     },
//                     child: Expanded(
//                       child: Container(
//                         height: 30,
//                         width: 80,
//                         margin: const EdgeInsets.only(left: 5),
//                         decoration: BoxDecoration(
//                             color: btnTapIndex == index
//                                 ? secondaryColors
//                                 : primary,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(50))),
//                         child: Center(
//                             child: Text(
//                           btnlist[index],
//                           style: myTextStyle(
//                               btnTapIndex != index ? secondaryColors : primary,
//                               0.008.toResponsive(context),
//                               " Roboto"),
//                         )),
//                       ),
//                     ),
//                   ))
//         ],
//       ),
//     );
//   }

//   Container searchBar(BuildContext context) => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         height: 0.06.h(context),
//         width: 1.0.w(context),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2.2,
//             style: BorderStyle.solid,
//             color: textColor,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 0.06.h(context),
//               width: 0.2.w(context),
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/searchicons.png"),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 width: 0.7.w(context),
//                 height: 0.06.h(context),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search by table or category",
//                     hintStyle: myTextStyle(
//                         textColor, 0.015.toResponsive(context), "Roboto"),
//                     border: InputBorder.none,
//                   ),
//                   keyboardType: TextInputType.text,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );

//   Container logoHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       color: primary,
//       height: 0.15.h(context),
//       width: 1.0.w(context),
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 0.08.h(context),
//                   width: 0.2.w(context),
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/images/logo_images.png"))),
//                 ),
//                 SizedBox(
//                   width: 0.0040.w(context),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       logoText,
//                       style: myTextStyle(
//                           textColor, 0.018.toResponsive(context), "Roboto"),
//                     ),
//                     Text(
//                       address,
//                       style: myTextStyle(
//                           textColor, 0.011.toResponsive(context), "Roboto"),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   width: 0.0030.w(context),
//                 ),
//               ],
//             ),
//             IconButton(
//                 onPressed: () {},
//                 icon: Image.asset("assets/images/notification.png"))
//           ]),
//     );
//   }
// }

import 'package:brosoftresturent/model/tables_model.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/table_controller.dart';
import '../../utils/app_style.dart';
import '../widgets/custome_btns.dart';
import '../widgets/custome_inputs.dart';
import 'models/btnmodels.dart';

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

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final customernoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var filterTable = filterItems();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 0.01.toResponsive(context),
          right: 0.01.toResponsive(context),
        ),
        child: Column(
          children: [
            logoHeader(context),
            SizedBox(
              height: 0.018.h(context),
            ),
            searchBar(context),
            SizedBox(
              height: 0.018.h(context),
            ),
            selectedBtn(context),
            SizedBox(
              height: 0.018.h(context),
            ),
            //tableItems
            SizedBox(
              height: 0.65.h(context),
              width: 1.0.w(context),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filterTable.length,
                  itemBuilder: (context, index1) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filterTable[index1].tabletype,
                            style: myTextStyle(secondaryColors,
                                0.015.toResponsive(context), "Roboto"),
                          ),
                          SizedBox(
                            height: 0.05.w(context),
                          ),
                          SizedBox(
                              // color: Colors.red,
                              height: 0.5.h(context),
                              width: 1.0.w(context),
                              child: GridView.builder(
                                  itemCount:
                                      filterTable[index1].tableItem.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index2) {
                                    var tableItems =
                                        filterTable[index1].tableItem[index2];
                                    return GestureDetector(
                                      onTap: () {
                                        tableItems.reserved == true
                                            ? Get.bottomSheet(
                                                bottomSheetReserved(
                                                    context,
                                                    tableItems.tableName,
                                                    tableItems.seat))
                                            : Get.bottomSheet(
                                                bottomSheetNoReserved(
                                                context,
                                                tableItems.tableName,
                                                tableItems.seat,
                                              ));
                                      },
                                      child: Card(
                                        color: tableItems.reserved == true
                                            ? reservedColor
                                            : primary,
                                        margin: const EdgeInsets.all(4),
                                        child: Stack(children: [
                                          Positioned(
                                              top: 0.010.h(context),
                                              right: 0.02.h(context),
                                              child: Text(
                                                tableItems.tableName,
                                                style: TextStyle(
                                                    color: secondaryColors,
                                                    fontSize: 0.019
                                                        .toResponsive(context),
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Roboto"),
                                              )),
                                          Positioned(
                                            bottom: 0.01.h(context),
                                            child: Row(children: [
                                              Container(
                                                height: 0.05.w(context),
                                                width: 0.08.w(context),
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/imageperson.png"))),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${tableItems.seat} ",
                                                    style: myTextStyle(
                                                        secondaryColors,
                                                        0.015.toResponsive(
                                                            context),
                                                        "Roboto"),
                                                  ),
                                                  Text(
                                                    "people",
                                                    style: myTextStyle(
                                                        textColor,
                                                        0.013.toResponsive(
                                                            context),
                                                        "Roboto"),
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
            )
          ],
        ),
      ),
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
      height: 0.045.h(context),
      width: 1.0.w(context),
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
                      height: 0.8.h(context),
                      width: 0.2.w(context),
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
              style: myTextStyle(secondaryColors, 0.018.toResponsive(context),
                  "RobotoRegular"),
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
    BuildContext context,
    String tableName,
    int numberGust,
  ) {
    return Container(
      height: 1.0.h(context),
      width: 1.0.toResponsive(context),
      padding: EdgeInsets.only(
          left: 0.020.toResponsive(context),
          right: 0.020.toResponsive(context)),
      decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40))),
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
                  "Table",
                  style: myTextStyle(
                      textColor, 0.015.toResponsive(context), "RobotoRegular"),
                ),
                SizedBox(
                  width: 0.005.w(context),
                ),
                Text(
                  tableName,
                  style: myTextStyle(secondaryColors,
                      0.018.toResponsive(context), "RobotoRegular"),
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
                    style: myTextStyle(textColor, 0.015.toResponsive(context),
                        "RobotoRegular"),
                  ),
                  Text(
                    numberGust.toString(),
                    style: TextStyle(
                        color: secondaryColors,
                        fontSize: 0.018.toResponsive(context),
                        fontWeight: FontWeight.w700,
                        fontFamily: "RobotoRegular"),
                  ),

                  //btnContainer
                  Container(
                    height: 0.045.h(context),
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
                                log("increment");
                              },
                              child: Image.asset("assets/images/Add icon.png")),
                          const VerticalDivider(
                            color: textColor,
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Image.asset(
                                  "assets/images/subtract icon.png"))
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
                    style: myTextStyle(textColor, 0.015.toResponsive(context),
                        "RobotoRegular"),
                  ),
                  Container(
                    height: 0.4.h(context),
                    width: 0.09.w(context),
                    decoration: const BoxDecoration(
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
                Container(
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
                Container(
                  color: Colors.red,
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
            Container(
              height: 0.058.h(context),
              width: 1.0.w(context),

              // padding: EdgeInsets.all(0.005.toResponsive(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBtn(
                    height: 0.5.h(context),
                    btnTitle: "Reserved",
                    onPressed: () {},
                    color: btnSecondaryColor,
                    width: 0.4.w(context),
                  ),
                  CustomBtn(
                    height: 1.0.h(context),
                    btnTitle: "Start",
                    onPressed: () {},
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
}
