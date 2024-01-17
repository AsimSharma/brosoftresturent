import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/tables_model.dart';
import '../../../utils/app_style.dart';
import '../../../utils/random_number.dart';
import '../../OrderSelectPage/SelectedFoodItems/screen/selected_order.dart';
import '../../widgets/shared/cancel_btns.dart';
import '../models/images.dart';

class ChooseRelatedOrderBottomSheet extends StatelessWidget {
  const ChooseRelatedOrderBottomSheet({
    super.key,
    required this.tableItem,
  });

  final TableItem tableItem;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        constraints: BoxConstraints(
            minHeight: 0.02.h(context), maxHeight: 0.55.h(context)),
        decoration: const BoxDecoration(
            color: btnBghColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.01.toResponsive(context)),
              child: Row(
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
                  CancelButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
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
                        MenuOptions(
                          tableItem: tableItem,
                          index: 0,
                        ),
                        SizedBox(
                          width: 0.013.toResponsive(context),
                        ),
                        MenuOptions(
                          tableItem: tableItem,
                          index: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.015.h(context),
                    ),
                    MenuOptions(
                      tableItem: tableItem,
                      index: 2,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({
    super.key,
    required this.tableItem,
    required this.index,
  });

  final TableItem tableItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        Get.to(() => SelectedOrder(
            tablename: tableItem.tableName,
            totalGuest: tableItem.totalguest!,
            orderNo: getRandomnumber()));
      },
      child: Container(
        height: 0.1.h(context),
        width: 0.31.w(context),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1, color: secondaryColors)),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset(imageListcro[index]['imageName'] ?? ""),
              Text(
                imageListcro[index]['name'] ?? "",
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
