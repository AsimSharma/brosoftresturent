import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order_cart_controller.dart';
import '../../../../utils/app_style.dart';

class GrandTotal extends StatelessWidget {
  const GrandTotal({
    super.key,
    required this.orderController,
    required this.onBack,
  });

  final OrDerController orderController;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.20.h(context),
      width: 1.0.w(context),
      padding: const EdgeInsets.all(10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left
            InkWell(
              onTap: onBack,
              child: Container(
                height: 0.06.h(context),
                padding: EdgeInsets.all(0.010.toResponsive(context)),
                decoration: const BoxDecoration(
                    color: btnBghColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border:
                          Border.all(color: const Color(0xFF000000), width: 2),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: secondaryColors,
                      size: 15,
                    ),
                  ),
                  SizedBox(
                    width: 0.016.w(context),
                  ),
                  Text(
                    "Add More Item",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "RobotoRegular",
                        fontWeight: FontWeight.w900,
                        fontSize: 0.014.toResponsive(context)),
                  )
                ]),
              ),
            ),
            //right
            Obx(
              () => SizedBox(
                // width: 0.6.w(context),
                height: 1.0.h(context),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //total
                      PricesListTile(
                          leadingTitle: "Total",
                          pricesAmount: orderController
                              .calculateTotalPrices()
                              .toString()),

                      PricesListTile(
                          leadingTitle: "Services Tax",
                          pricesAmount:
                              orderController.getServicTax().toString()),

                      PricesListTile(
                        leadingTitle: "Vat 13%",
                        pricesAmount: orderController.getVatTax().toString(),
                      ),

                      PricesListTile(
                        leadingTitle: "Grand Total",
                        pricesAmount:
                            orderController.grandTotalPrices().toString(),
                        textColors: secondaryColors,
                        fontWeights: FontWeight.w900,
                      ),
                    ]),
              ),
            )
          ]),
    );
  }
}

class PricesListTile extends StatelessWidget {
  const PricesListTile({
    super.key,
    required this.leadingTitle,
    required this.pricesAmount,
    this.textColors = const Color.fromARGB(255, 145, 145, 145),
    this.fontWeights = FontWeight.w500,
  });

  final String leadingTitle;
  final String pricesAmount;
  final Color textColors;
  final FontWeight fontWeights;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          leadingTitle,
          style: TextStyle(
              color: textColors,
              fontFamily: "Roboto",
              fontWeight: fontWeights,
              fontSize: 0.015.toResponsive(context)),
        ),
        SizedBox(
          width: 0.03.w(context),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.003.toResponsive(context)),
              child: Text(
                "रु",
                style: TextStyle(
                    color: textColors,
                    fontFamily: "Roboto",
                    fontWeight: fontWeights,
                    fontSize: 0.015.toResponsive(context)),
              ),
            ),
            Text(
              pricesAmount,
              style: TextStyle(
                  color: textColors,
                  fontFamily: "Roboto",
                  fontWeight: fontWeights,
                  fontSize: 0.015.toResponsive(context)),
            ),
          ],
        )
      ],
    );
  }
}
