import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/table/widgets/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controller/table_controller.dart';
import '../../../model/tables_model.dart';
import '../../../utils/app_style.dart';
import '../../widgets/shared/custome_btns.dart';
import '../../widgets/shared/custome_inputs.dart';

import 'choose_related_order.dart';

class TableGridItem extends StatefulWidget {
  const TableGridItem({
    super.key,
    required this.filterTable,
  });

  final List<TableModel> filterTable;

  @override
  State<TableGridItem> createState() => _TableGridItemState();
}

class _TableGridItemState extends State<TableGridItem> {
  final nameController = TextEditingController();

  final numberController = TextEditingController();

  final customernoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.62.h(context),
      width: 1.0.w(context),
      child: Obx(
        () => ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            itemCount: widget.filterTable.length,
            itemBuilder: (context, index1) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.filterTable[index1].tabletype,
                      style: myTextStyle(secondaryColors,
                          0.015.toResponsive(context), "Roboto"),
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
                            itemCount:
                                widget.filterTable[index1].tableItem.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index2) {
                              var tables = widget.filterTable[index1];
                              var tableItems =
                                  widget.filterTable[index1].tableItem[index2];

                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return bottomSheetNoReserved(
                                            context, tables, tableItems);
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
                                                  0.023.toResponsive(context),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Roboto"),
                                        )),
                                    Positioned(
                                      bottom: 0.01.h(context),
                                      child: Row(children: [
                                        SizedBox(
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
                                                  0.017.toResponsive(context),
                                                  "Roboto"),
                                            ),
                                            Text(
                                              "people",
                                              style: myTextStyle(
                                                  textColor,
                                                  0.013.toResponsive(context),
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
      ),
    );
  }

  //nonReserved
  Container bottomSheetNoReserved(
      BuildContext context, TableModel tables, TableItem tablesItems) {
    final tableController = Get.find<TableController>();
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
                  tablesItems.tableName,
                  style: TextStyle(
                      color: secondaryColors,
                      fontSize: 0.017.toResponsive(context),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),

            SizedBox(
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
                      tableController
                          .findAddedGuest(tablesItems.tid)
                          .toString(),
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
                                    tables, tablesItems);

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
                                  tables,
                                  tablesItems,
                                );
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
            SizedBox(
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
                  InkWell(
                    onTap: () {
                      Get.to(() => const QrCodeReader());
                    },
                    child: Container(
                      height: 0.31.h(context),
                      width: 0.071.w(context),
                      decoration: const BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("assets/images/Barcode.png"))),
                    ),
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
                    btnTitle: tablesItems.reserved == true
                        ? "UnReserved"
                        : "Reserved",
                    onPressed: () {
                      tableController.changeReserved(tables, tablesItems);

                      Get.back();
                    },
                    color: tablesItems.reserved == true
                        ? Colors.orange
                        : btnSecondaryColor,
                    width: 0.4.w(context),
                  ),
                  CustomBtn(
                    height: 1.0.h(context),
                    btnTitle: "Start",
                    onPressed: () {
                      Get.back();

                      tableController.findAddedGuest(tablesItems.tid) > 0
                          ? showDialog(
                              // backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return ChooseRelatedOrderBottomSheet(
                                  tableItem: tablesItems,
                                );
                              })
                          : Fluttertoast.showToast(
                              msg: "guest can't be Zero",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);

                      tablesItems.reserved == false
                          ? tableController.changeReserved(tables, tablesItems)
                          : null;
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
}
