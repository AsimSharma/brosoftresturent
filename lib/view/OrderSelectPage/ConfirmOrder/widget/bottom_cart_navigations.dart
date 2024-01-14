import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../controller/remote_order_controller.dart';
import '../../../../model/remote_order_models.dart';
import '../../../../utils/app_style.dart';
import '../../../widgets/shared/nepalirs.dart';
import '../../order_placed_screen.dart';

class BottomCartNavigationBar extends StatelessWidget {
  const BottomCartNavigationBar({
    super.key,
    required this.isAddedOrders,
    required this.tablename,
    required this.orderId,
    required this.orderNo,
    required this.totalGuest,
  });

  final bool isAddedOrders;
  final String tablename, orderId;
  final int orderNo, totalGuest;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrDerController>();
    final remoteOrderController = Get.find<RemoteOrderCtrl>();

    return Container(
      height: 0.08.h(context),
      width: 1.0.w(context),
      margin: EdgeInsets.all(0.002.toResponsive(context)),
      decoration: const BoxDecoration(
          color: secondaryColors,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      orderController.getTotalItems().toString(),
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
                  const NepaliRSw(
                    fontWeight: FontWeight.w700,
                  ),
                  Obx(
                    () => Text(
                      orderController.grandTotalPrices().toString(),
                      style: myTextStyle(
                          primary, 0.015.toResponsive(context), "Roboto"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 0.16.w(context),
          ),

          InkWell(
            onTap: () {
              RemoteOrderModel newOrder = RemoteOrderModel(
                  orderNo: orderNo,
                  totalGuest: totalGuest,
                  tableName: tablename,
                  time: DateTime.now(),
                  scheduleFor: DateTime.now(),
                  isCompleted: false,
                  orders: orderController.addItems,
                  addedOrders: [],
                  id: "$orderNo");

              isAddedOrders == false
                  ? remoteOrderController.addOrders(newOrder)
                  : remoteOrderController.updateAddOrders(
                      orderId, orderController.addItems);

              Get.to(() => OrderPlacedSucess(
                    orderNo: orderNo,
                  ));
            },
            child: Container(
              height: 0.06.h(context),
              width: 0.3.w(context),
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  "confirm Order",
                  style: myTextStyle(
                      textColor, 0.012.toResponsive(context), "Roboto"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
