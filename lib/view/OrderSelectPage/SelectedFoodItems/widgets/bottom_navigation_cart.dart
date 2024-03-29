import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../utils/app_style.dart';
import '../../../widgets/toast_message.dart';
import '../../ConfirmOrder/screen/confirm_selected_order.dart';
import '../screen/selected_order.dart';

class BottoNavigations extends StatelessWidget {
  const BottoNavigations({
    super.key,
    required this.orderCartController,
    required this.widget,
  });

  final OrDerController orderCartController;
  final SelectedOrder widget;

  @override
  Widget build(BuildContext context) {
    final orderCartController = Get.find<OrDerController>();
    return Container(
      height: 0.08.h(context),
      width: 0.8.w(context),
      //todo change margin hori vertical and height 0.008h
      margin: EdgeInsets.all(0.005.toResponsive(context)),
      decoration: const BoxDecoration(
          color: secondaryColors,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.05.w(context),
          ),
          //itemsrs

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      orderCartController.getTotalItems().toString(),
                      style: myTextStyle(
                          primary, 0.015.toResponsive(context), "Roboto"),
                    ),
                  ),
                  Text(
                    " items",
                    style: myTextStyle(
                        primary, 0.015.toResponsive(context), "Roboto"),
                  )
                ],
              ),
              SizedBox(
                width: 0.05.w(context),
              ),
              Image.asset("assets/images/vectro7.png"),
              SizedBox(
                width: 0.05.w(context),
              ),
              Row(
                children: [
                  Image.asset("assets/images/nepalirs (1).png"),
                  Obx(
                    () => Text(
                      orderCartController.calculateTotalPrices().toString(),
                      style: myTextStyle(
                          primary, 0.015.toResponsive(context), "Roboto"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 0.09.w(context),
          ),

          InkWell(
            onTap: () {
              orderCartController.addItems.isEmpty
                  ? Fluttertoast.showToast(
                      msg: "Add some foodsItems in cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0)
                  : Get.to(() => ConfirmOrderScreen(
                      tableName: widget.tablename,
                      totalGuest: widget.totalGuest,
                      orderNo: widget.orderNo,
                      isAddOrders: widget.isAddOrders,
                      orderId: widget.orderId ?? "120"));
            },
            child: Container(
              height: 0.06.h(context),
              width: 0.3.w(context),
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  "View Order",
                  style: myTextStyle(
                      textColor, 0.012.toResponsive(context), "Roboto"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 0.026.w(context),
          ),
        ],
      ),
    );
  }
}
