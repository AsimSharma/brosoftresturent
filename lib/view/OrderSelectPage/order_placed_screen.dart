import 'package:brosoftresturent/controller/order_cart_controller.dart';

import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';

import 'package:brosoftresturent/view/widgets/shared/custome_btns.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home.dart';

class OrderPlacedSucess extends StatelessWidget {
  const OrderPlacedSucess({
    super.key,
    required this.orderNo,
  });

  final int orderNo;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrDerController>();

    return Scaffold(
      backgroundColor: btnBghColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 0.2.h(context),
                  width: 1.0.w(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/sucess.png"))),
                ),
              ),
              SizedBox(
                height: 0.008.h(context),
              ),
              Text(
                "CONGRATULATIONS!",
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontWeight: FontWeight.w600,
                    fontFamily: "RobotoRegular"),
              ),
              SizedBox(
                height: 0.008.h(context),
              ),
              Text(
                "YOUR ORDER HAS BEEN PLACE SUCCESSFULLY",
                style: TextStyle(
                    color: secondaryColors,
                    fontWeight: FontWeight.w800,
                    fontSize: 0.014.toResponsive(context),
                    fontFamily: "RobotoRegular"),
              ),
              SizedBox(
                height: 0.008.h(context),
              ),
              Text(
                "YOUR ORDER ID: $orderNo",
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto"),
              ),
              SizedBox(
                height: 0.015.h(context),
              ),
              CustomBtn(
                btnTitle: "Done",
                onPressed: () {
                  Get.to(() => const HomeScreen());
                  orderController.clearCart();
                },
                height: 0.065.h(context),
                width: 0.55.w(context),
              ),
              SizedBox(
                height: 0.018.h(context),
              ),
              CustomBtn(
                btnTitle: "View order Details",
                onPressed: () {
                  Get.back();
                },
                height: 0.065.h(context),
                width: 0.55.w(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
