import 'package:brosoftresturent/controller/remote_order_controller.dart';

import 'package:brosoftresturent/model/remote_order_models.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:developer';

import '../../utils/app_style.dart';
import '../OrderSelectPage/SelectedFoodItems/screen/selected_order.dart';
import '../widgets/shared/logo_app_bar.dart';
import '../widgets/shared/search_bar.dart';
import 'widgets/addedorders.dart';
import 'widgets/orders_lists.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final remoteOrderCtrl = Get.put(RemoteOrderCtrl());

  int btnTapIndex = 0;

  @override
  void initState() {
    btnTapIndex = 0;
    // remoteOrderCtrl.getHistoryOrders();
    super.initState();
  }

  String selectedValue = "";

  List<RemoteOrderModel> filterList() {
    if (selectedValue.isNotEmpty) {
      return remoteOrderCtrl.remoteOrderList
          .where((p0) => p0.orderNo.toString().contains(selectedValue))
          .toList();
    } else {
      remoteOrderCtrl.remoteOrderList.reversed;
      return remoteOrderCtrl.remoteOrderList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterValue = filterList();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LogoAppBar(),
                  orderHistory(context),
                  SizedBox(
                    height: 0.015.h(context),
                  ),
                  SearchBarContainer(
                    hintText: "Search by order number",
                    onChangeValue: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.015.h(context),
                  ),

                  //orderHistorylistView
                  btnTapIndex == 0
                      ? Obx(
                          () => SizedBox(
                            height: 0.625.h(context),
                            width: 1.0.w(context),
                            child: ListView.builder(
                                itemCount: filterValue.length,
                                itemBuilder: (context, index1) {
                                  var orderData = filterValue[index1];
                                  int time = DateTime.now()
                                      .difference(orderData.time)
                                      .inMinutes;
                                  return Visibility(
                                    key: UniqueKey(),
                                    visible:
                                        orderData.isCompleted == false ?? false,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(11)),
                                          border: Border.all(
                                              color: secondaryColors,
                                              width: 2.0)),
                                      margin: EdgeInsets.only(
                                          top: 0.01.toResponsive(context)),
                                      child: Column(
                                        children: [
                                          //toheader
                                          topHeader(
                                              context, btnTapIndex, orderData),

                                          // OrderSItems listItems
                                          OrderList(
                                              filterValue: filterValue,
                                              index1: index1),

                                          filterValue[index1]
                                                  .addedOrders
                                                  .isNotEmpty
                                              ? Container(
                                                  padding: EdgeInsets.all(0.010
                                                      .toResponsive(context)),
                                                  child: Column(
                                                    children: [
                                                      const Divider(
                                                        color: secondaryColors,
                                                      ),
                                                      AddedOrdersList(
                                                          filterValue:
                                                              filterValue,
                                                          index1: index1)
                                                    ],
                                                  ),
                                                )
                                              : const Text(""),

                                          // OrderList(
                                          //     filterValue: filterValue,
                                          //     index1: index1),

                                          const Divider(
                                            color: secondaryColors,
                                          ),

                                          addDeleteSections(
                                              context, btnTapIndex, orderData)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Obx(
                          () => SizedBox(
                            height: 0.625.h(context),
                            width: 1.0.w(context),
                            child: ListView.builder(
                                itemCount: filterValue.length,
                                itemBuilder: (context, index1) {
                                  var orderData = filterValue[index1];
                                  return Visibility(
                                    key: UniqueKey(),
                                    visible:
                                        orderData.isCompleted == true ?? true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(11)),
                                          border: Border.all(
                                              color: textColor, width: 2.0)),
                                      margin: EdgeInsets.only(
                                          top: 0.01.toResponsive(context)),
                                      child: Column(
                                        children: [
                                          //toheader
                                          topHeader(
                                              context, btnTapIndex, orderData),
                                          // OrderSItems listItems
                                          OrderList(
                                            filterValue: filterValue,
                                            index1: index1,
                                          ),
                                          const Divider(
                                            color: secondaryColors,
                                          ),
                                          addDeleteSections(
                                              context, btnTapIndex, orderData)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                ],
              ),
            )),
      ),
    );
  }

  Container addDeleteSections(
      BuildContext context, int btnTapIndex, RemoteOrderModel orderData) {
    return Container(
        height: 0.09.h(context),
        width: 1.0.w(context),
        padding: EdgeInsets.symmetric(horizontal: 0.0035.toResponsive(context)),
        child: btnTapIndex == 0
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //left
                Row(
                  children: [
                    SizedBox(width: 0.012.w(context)),
                    Container(
                        height: 0.06.h(context),
                        width: 0.03.h(context),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/cance_icons.png")))),
                    SizedBox(width: 0.012.w(context)),
                    InkWell(
                      onTap: () {
                        remoteOrderCtrl.isLoading2 == true
                            ? const CircularProgressIndicator()
                            : remoteOrderCtrl.cancelById(orderData.id);
                      },
                      child: Text(
                        "Cancle Order",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 0.015.toResponsive(context)),
                      ),
                    )
                  ],
                ),
                //right
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColors,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                            color: const Color(0xFF000000), width: 2),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: primary,
                        size: 15,
                      ),
                    ),
                    SizedBox(width: 0.012.w(context)),
                    InkWell(
                      onTap: () {
                        Get.to(() => SelectedOrder(
                              tablename: orderData.tableName,
                              totalGuest: orderData.totalGuest,
                              orderNo: orderData.orderNo,
                              isAddOrders: true,
                              orderId: orderData.id,
                            ));
                      },
                      child: Text(
                        "Add Order",
                        style: TextStyle(
                            color: secondaryColors,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 0.015.toResponsive(context)),
                      ),
                    ),
                    SizedBox(width: 0.012.w(context)),
                  ],
                )
              ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Complets",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        fontSize: 0.015.toResponsive(context)),
                  )
                ],
              ));
  }

  Container topHeader(
      BuildContext context, int btnIndex, RemoteOrderModel orderData) {
    int time = DateTime.now().difference(orderData.time).inMinutes;
    return Container(
      height: 0.07.h(context),
      width: 1.0.w(context),
      padding: EdgeInsets.all(0.015.toResponsive(context)),
      decoration: BoxDecoration(
          color: btnTapIndex == 0 ? secondaryColors : btnBghColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(11), topLeft: Radius.circular(11))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //left
        Row(
          children: [
            Text(
              "Table",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.013.toResponsive(context)),
            ),
            SizedBox(
              width: 0.025.w(context),
            ),
            Text(orderData.tableName ?? "",
                style: TextStyle(
                    color: btnTapIndex == 0 ? primary : textColor,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 0.013.toResponsive(context))),
            SizedBox(
              width: 0.02.w(context),
            ),
            Image.asset(
                "assets/images/${btnTapIndex == 0 ? "vectro7.png" : "Vector 13.png"}"),
            SizedBox(
              width: 0.02.w(context),
            ),
            Text(
              "${orderData.orders.length.toString()} items",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.012.toResponsive(context)),
            ),
          ],
        ),
        //Right

        Row(
          children: [
            Row(
              children: [
                Text(
                  "OrderNo",
                  style: TextStyle(
                      color: btnTapIndex == 0 ? primary : textColor,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 0.013.toResponsive(context)),
                ),
                SizedBox(
                  width: 0.02.w(context),
                ),
                Text(
                  orderData.orderNo.toString() ?? "",
                  style: TextStyle(
                      color: btnTapIndex == 0 ? primary : textColor,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 0.013.toResponsive(context)),
                ),
              ],
            ),
            SizedBox(
              width: 0.02.w(context),
            ),
            Image.asset(
                "assets/images/${btnTapIndex == 0 ? "vectro7.png" : "Vector 13.png"}"),
            SizedBox(
              width: 0.02.w(context),
            ),
            Text(
              "${time.toString()} m ago ",
              style: TextStyle(
                  color: btnTapIndex == 0 ? primary : textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 0.013.toResponsive(context)),
            ),
          ],
        )
      ]),
    );
  }

  Container orderHistory(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0058.toResponsive(context)),
      height: 0.045.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                btnTapIndex = 0;
                log(btnTapIndex.toString());
              });
            },
            child: Text(
              "Order",
              style: TextStyle(
                  color: textColor,
                  fontFamily: "RobotoRegular",
                  fontWeight: FontWeight.w600,
                  fontSize: 0.017.toResponsive(context)),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                btnTapIndex = 1;
                log(btnTapIndex.toString());
              });
            },
            child: Container(
              height: 0.9.h(context),
              width: 0.13.w(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/orderhistory.png"))),
            ),
          )
        ],
      ),
    );
  }
}
