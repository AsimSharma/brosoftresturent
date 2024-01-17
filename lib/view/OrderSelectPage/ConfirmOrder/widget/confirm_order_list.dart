import 'dart:developer';

import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../model/remote_order_models.dart';
import '../../../../utils/app_style.dart';

class ConfirmOrderListItems extends StatefulWidget {
  const ConfirmOrderListItems({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<ConfirmOrderListItems> createState() => _ConfirmOrderListItemsState();
}

class _ConfirmOrderListItemsState extends State<ConfirmOrderListItems> {
  String noteText = "";
  bool addNote = false;
  final orderController = Get.find<OrDerController>();
  bool addNotesClicked = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.order.quantity > 0,
      child: Container(
        margin: EdgeInsets.only(top: 0.005.toResponsive(context)),
        padding: EdgeInsets.all(0.005.toResponsive(context)),
        constraints: BoxConstraints(
          minHeight: 0.08.h(context),
          minWidth: 0.5.w(context),
        ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 245, 239, 238),
            boxShadow: [
              BoxShadow(
                  // spreadRadius: 5,
                  blurRadius: 1,
                  color: Colors.black,
                  offset: Offset(0.0, 0.0005))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 0.04.h(context),
                    width: 0.04.w(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.order.isVeg != true
                                ? "assets/images/Non-veg Icon.png"
                                : "assets/images/Veg Icon.png"))),
                  ),
                  SizedBox(
                    width: 0.01.w(context),
                  ),
                  Text(
                    widget.order.foodName,
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "RobotoRegular",
                        fontWeight: FontWeight.w900,
                        fontSize: 0.014.toResponsive(context)),
                  ),
                ],
              ),
              Container(
                height: 0.05.h(context),
                width: 0.25.w(context),
                padding: EdgeInsets.all(0.0075.toResponsive(context)),
                decoration: const BoxDecoration(
                    color: secondaryColors,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            // productController
                            orderController.decraseCartQuantity(widget.order);
                          },
                          child: SizedBox(
                            height: 0.045.h(context),
                            width: 0.035.w(context),
                            // color: Colors.red,
                            child: Image.asset("assets/images/subwhite.png"),
                          )),
                      Text(
                        widget.order.quantity.toString(),
                        style: myTextStyle(primary, 0.015.toResponsive(context),
                            "RobotoRegular"),
                      ),
                      InkWell(
                          onTap: () {
                            orderController.increaseCartQuantity(widget.order);
                          },
                          child: SizedBox(
                            height: 0.045.h(context),
                            width: 0.035.w(context),
                            // color: Colors.red,
                            child: Image.asset("assets/images/addwhite.png"),
                          )),
                    ]),
              ),
            ],
          ),
          //bottom

          Padding(
            padding: EdgeInsets.all(0.008.toResponsive(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //checkedCondations
                //todo isNotes  is  is click cancle notes then updateNote("")
                //notes walaa
                Visibility(
                  visible: addNotesClicked == false,
                  child: AddNotesBtn(
                    onTap: () {
                      orderController.updateNote(noteText, widget.order.fid);
                      log("is Added ${widget.order.isAdded}");
                      setState(() {
                        addNotesClicked = true;
                        log("The click Status is $addNotesClicked");
                      });
                    },
                  ),
                ),

                Visibility(
                  visible: addNotesClicked == true,
                  child: Obx(
                    () => orderController.checkedNotes(widget.order.fid) == true
                        ? Container(
                            constraints: BoxConstraints(
                              minHeight: 0.05.h(context),
                              maxHeight: 0.08.h(context),
                              minWidth: 0.55.w(context),
                            ),
                            decoration: BoxDecoration(
                                color: btnBghColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: secondaryColors,
                                  width: 1.0,
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 0.8.h(context),
                                  width: 0.41.w(context),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: widget.order.note ?? "",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        noteText = value;
                                        log(" your Note: $noteText");
                                        orderController.updateNote(
                                            noteText, widget.order.fid);
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      orderController.updateNote(
                                          "", widget.order.fid);
                                      log("is Added ${widget.order.isAdded}");
                                      setState(() {
                                        addNotesClicked = false;
                                        log("The click Status is $addNotesClicked");
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                          )
                        : Container(
                            constraints: BoxConstraints(
                              minHeight: 0.05.h(context),
                              maxHeight: 0.08.h(context),
                              minWidth: 0.55.w(context),
                            ),
                            decoration: BoxDecoration(
                                color: btnBghColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: secondaryColors,
                                  width: 1.0,
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 0.8.h(context),
                                  width: 0.41.w(context),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        noteText = value;
                                        log(" your Note: $noteText");
                                        orderController.updateNote(
                                            noteText, widget.order.fid);
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      orderController.updateNote(
                                          "", widget.order.fid);
                                      log("is Added ${widget.order.isAdded}");
                                      setState(() {
                                        addNotesClicked = false;
                                        log("The click Status is $addNotesClicked");
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                          ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 0.045.h(context),
                      width: 0.035.w(context),
                      child: Image.asset("assets/images/nepalirupees.png"),
                    ),
                    Text(
                      orderController
                          .calculateIndivisualPrices(widget.order)
                          .toString(),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 138, 133, 133),
                          fontSize: 0.014.toResponsive(context),
                          fontWeight: FontWeight.w900,
                          fontFamily: "RobotRegular"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class AddNotesBtn extends StatelessWidget {
  const AddNotesBtn({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 0.05.h(context),
        width: 0.35.w(context),
        // color: Colors.red,
        padding: EdgeInsets.all(0.008.toResponsive(context)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: const Color(0xFF000000), width: 2),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: secondaryColors,
                size: 15,
              ),
            ),
            SizedBox(
              width: 0.01.w(context),
            ),
            Text(
              "Add note",
              style: TextStyle(
                  color: secondaryColors,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 0.014.toResponsive(context)),
            ),
          ],
        ),
      ),
    );
  }
}
