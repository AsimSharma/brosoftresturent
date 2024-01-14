import 'dart:developer';
import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/controller/remote_order_controller.dart';

import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/remote_productcontroller.dart';
import '../../widgets/header_app_bar.dart';
import '../../widgets/table_order_info.dart';
import '../widget/bottom_cart_navigations.dart';
import '../widget/confirm_order_list.dart';
import '../widget/grand_total.dart';
import '../widget/orderinfo_sheduilg_bar.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen(
      {super.key,
      required this.tableName,
      required this.totalGuest,
      required this.orderNo,
      required this.isAddOrders,
      required this.orderId});
  final String tableName;
  final int totalGuest;
  final int orderNo;
  final bool isAddOrders;
  final String orderId;

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final orderController = Get.find<OrDerController>();
  final productController = Get.find<RemoteProductCtrl>();
  final remoteOrderCtrl = Get.put(RemoteOrderCtrl());

  TimeOfDay selectedTime = TimeOfDay.now();
  showPickTime(BuildContext context) async {
    final TimeOfDay? pickTime =
        await showTimePicker(context: context, initialTime: selectedTime);

    if (pickTime != null) {
      setState(() {
        selectedTime = pickTime;
      });
    }

    log("$pickTime");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomCartNavigationBar(
        isAddedOrders: widget.isAddOrders,
        tablename: widget.tableName,
        orderId: widget.orderId,
        orderNo: widget.orderNo,
        totalGuest: widget.totalGuest,
      ),
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
                HeadeAppBar(
                  titleName: "Confirm Order",
                  onPressed: () {
                    Get.to(() => const HomeScreen());
                    orderController.clearCart();
                  },
                ),
                SizedBox(
                  height: 0.004.h(context),
                ),
                TableOrderInfo(
                    tableName: widget.tableName,
                    totalGuest: widget.totalGuest,
                    orderNo: widget.orderNo),
                const Divider(),
                SizedBox(
                  height: 0.008.h(context),
                ),
                OrderInfoshedulingBar(
                  onTimePickUp: () {
                    showPickTime(context);
                  },
                ),
                SizedBox(
                  height: 0.008.h(context),
                ),
                Obx(() => SizedBox(
                      height: 0.45.h(context),
                      width: 1.0.w(context),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: orderController.addItems.length,
                          itemBuilder: ((context, index) {
                            var data = orderController.addItems[index];

                            return ConfirmOrderListItems(order: data);
                          })),
                    )),
                GrandTotal(
                  orderController: orderController,
                  onBack: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
