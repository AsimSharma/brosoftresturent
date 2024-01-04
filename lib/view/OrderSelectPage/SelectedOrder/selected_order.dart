import 'package:flutter/material.dart';

import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/controller/remote_productcontroller.dart';
import 'package:brosoftresturent/model/remote_products.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/images_path_store.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/table/models/images.dart';
import '../../table/models/btn_selected_model.dart';
import '../widgets/table_order_info.dart';
import 'widgets/bottom_navigation_cart.dart';

import 'package:get/get.dart';
import 'dart:developer';

import '../widgets/header_app_bar.dart';

class SelectedOrder extends StatefulWidget {
  const SelectedOrder({
    super.key,
    required this.tablename,
    required this.totalGuest,
    required this.oderNo,
  });

  final String tablename;
  final int totalGuest;
  final int oderNo;

  @override
  State<SelectedOrder> createState() => _SelectedOrderState();
}

class _SelectedOrderState extends State<SelectedOrder> {
  bool switchListTileValue = false;
  bool selectedRadio = false;
  String searchValue = "";
  int btnTapIndex = 0;

  final orderCartController = Get.put(OrDerController());

  final remoteProductCtrl = Get.put(RemoteProductCtrl());

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    remoteProductCtrl.getRemoteProductsItems();
    _filteredProducts();
    btnTapIndex = 0;
  }

  List<Foods> _filteredProducts() {
    if (searchValue.isNotEmpty) {
      return remoteProductCtrl.productList
          .where((product) =>
              (product.foodCategories.toLowerCase()).contains(searchValue))
          .toList();
    } else {
      if (btnTapIndex == 0) {
        return remoteProductCtrl.productList;
      } else {
        var selectedCategory = btnlistOrder[btnTapIndex];
        return remoteProductCtrl.productList
            .where((product) => product.foodCategories == selectedCategory)
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var filterProduct = _filteredProducts();

    return Scaffold(
      bottomNavigationBar: BottoNavigations(
          orderCartController: orderCartController, widget: widget),
      body: SafeArea(
        child: Container(
          height: 0.92.h(context),
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //headerSections
              HeadeAppBar(
                titleName: "Selected Order",
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 0.004.h(context),
              ),

              TableOrderInfo(
                tableName: widget.tablename,
                totalGuest: widget.totalGuest,
                orderNo: widget.oderNo,
              ),

              const Divider(),
              SizedBox(
                height: 0.008.h(context),
              ),

              seaechBar(context),

              SizedBox(
                height: 0.015.h(context),
              ),
              //btnSelected
              selectedBtn(context),
              SizedBox(
                height: 0.018.h(context),
              ),
              //ui filter
              Obx(() => listviewProducts(
                    context,
                    widget.tablename,
                    filterProduct,
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  SizedBox listviewProducts(
      BuildContext context, String tableName, List<Foods> filterProduct) {
    return SizedBox(
      width: 1.0.w(context),
      height: 0.58.h(context),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: filterProduct.length,
        itemBuilder: (context, index1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filterProduct[index1].foodCategories,
                style: myTextStyle(
                    secondaryColors, 0.015.toResponsive(context), "Roboto"),
              ),
              SizedBox(
                height: 0.0125.h(context),
              ),
              SizedBox(
                height: 0.38.h(context),
                width: 1.0.w(context),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterProduct[index1].foodItems.length,
                    itemBuilder: (context, index2) {
                      var productItem = filterProduct[index1].foodItems[index2];
                      var images = imagesList[index2];
                      return Card(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 0.0015.toResponsive(context),
                              left: 0.0015.toResponsive(context)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("${images['imageName']}"),
                                SizedBox(
                                  height: 0.005.toResponsive(context),
                                ),
                                SizedBox(
                                  height: 0.015.toResponsive(context),
                                  width: 0.05.w(context),
                                  child: Image.asset(productItem.isVeg == false
                                      ? AppImages.novegImage
                                      : AppImages.vegImages),
                                ),
                                Text(
                                  productItem.fname.capitalize.toString(),
                                  style: TextStyle(
                                      color: secondaryColors,
                                      fontSize: 0.015.toResponsive(context),
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 0.045.h(context),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/bluenepali.png"),
                                          Text(
                                            productItem.prices
                                                .toString()
                                                .capitalize
                                                .toString(),
                                            style: TextStyle(
                                                color: secondaryColors,
                                                fontSize:
                                                    0.015.toResponsive(context),
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      productItem.isCustomize == true
                                          ? TextButton(
                                              onPressed: () {
                                                productItem.isCustomize == true
                                                    ? showBottomSheet(
                                                        context: context,
                                                        builder: (context) =>
                                                            customizeBootom(
                                                                context))
                                                    : "";
                                              },
                                              child: Text(
                                                "Customiasble",
                                                style: myTextStyle(
                                                    Colors.red,
                                                    0.0125
                                                        .toResponsive(context),
                                                    "Roboto"),
                                              ),
                                            )
                                          : const Text("")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 0.01.h(context),
                                ),
                                productItem.totalQuantity == 0
                                    ? InkWell(
                                        onTap: () async {
                                          orderCartController.addItemsOnCart(
                                              filterProduct[index1]
                                                  .foodItems[index2],
                                              tableName);

                                          remoteProductCtrl
                                              .increaseFoodQuantity(
                                                  filterProduct[index1],
                                                  filterProduct[index1]
                                                      .foodItems[index2]);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left:
                                                    0.020.toResponsive(context),
                                                right: 0.020
                                                    .toResponsive(context)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                border: Border.all(
                                                    color: secondaryColors,
                                                    width: 2)),
                                            margin: EdgeInsets.only(
                                                left:
                                                    0.04.toResponsive(context),
                                                right:
                                                    0.04.toResponsive(context)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Add",
                                              style: myTextStyle(
                                                  textColor,
                                                  0.015.toResponsive(context),
                                                  "Roboto"),
                                            )),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 0.025.toResponsive(context),
                                            right: 0.025.toResponsive(context)),
                                        height: 0.05.h(context),
                                        width: 0.3.w(context),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: secondaryColors,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    remoteProductCtrl
                                                        .decreaseFoodQuantity(
                                                            filterProduct[
                                                                index1],
                                                            filterProduct[
                                                                        index1]
                                                                    .foodItems[
                                                                index2]);

                                                    orderCartController
                                                        .decFoodQuanity(
                                                      filterProduct[index1]
                                                          .foodItems[index2],
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    height: 1.0.h(context),
                                                    width: 0.073.w(context),
                                                    child: Image.asset(
                                                        "assets/images/subwhite.png"),
                                                  )),
                                              Text(
                                                productItem.totalQuantity
                                                        .toString() ??
                                                    "1",
                                                style: TextStyle(
                                                    color: primary,
                                                    fontSize: 0.013
                                                        .toResponsive(context),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Roboto"),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    remoteProductCtrl
                                                        .increaseFoodQuantity(
                                                            filterProduct[
                                                                index1],
                                                            filterProduct[
                                                                        index1]
                                                                    .foodItems[
                                                                index2]);
                                                    orderCartController
                                                        .increaseFoodQuanity(
                                                      filterProduct[index1]
                                                          .foodItems[index2],
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    height: 1.0.h(context),
                                                    width: 0.073.w(context),
                                                    child: Image.asset(
                                                        "assets/images/addwhite.png"),
                                                  )),
                                            ]),
                                      ),
                                SizedBox(
                                  height: 0.015.h(context),
                                )
                              ]),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  Container customizeBootom(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 0.85.h(context),
      width: 1.0.w(context),
      child: Stack(children: [
        Positioned(
          left: 0.40.w(context),
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.black,
                size: 0.042.h(context),
              )),
        ),
        Positioned(
            top: 0.070.h(context),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 234, 233),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0.030.toResponsive(context)),
                      topLeft: Radius.circular(0.030.toResponsive(context)))),
              padding: EdgeInsets.only(
                left: 0.011.toResponsive(context),
                right: 0.011.toResponsive(context),
              ),
              height: 0.8.h(context),
              width: 1.0.w(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.01.h(context),
                  ),
                  Container(
                      height: 0.28.h(context),
                      width: 1.0.w(context),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/customizedimages.png")),
                          borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(0.010.toResponsive(context)),
                              topLeft: Radius.circular(
                                  0.010.toResponsive(context))))),
                  SizedBox(
                    height: 0.02.h(context),
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/Non-veg Tag.png"),
                      SizedBox(
                        width: 0.02.w(context),
                      ),
                      Text(
                        "Miso Ramen",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 0.016.toResponsive(context),
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 0.02.h(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.005.h(context),
                  ),
                  Text(
                    "Set the new password for your account so you can login and access all the features.",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        color: textColor,
                        fontSize: 0.0145.toResponsive(context),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 0.012.h(context),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Divider(
                      color: secondaryColors,
                    ),
                  ),
                  SizedBox(
                    height: 0.01.h(context),
                  ),
                  Text(
                    "Choose one (1/1)*",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 0.016.toResponsive(context),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800),
                  ),
                  chooseOne(context),
                  // chooseOne(context),
                  Text(
                    "Add On",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 0.016.toResponsive(context),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  Container chooseOne(BuildContext context) {
    return Container(
      height: 0.051.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Half",
            style: TextStyle(
                color: textColor,
                fontSize: 0.016.toResponsive(context),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w500),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/nepalirupees.png"),
              Text("200"),
              Radio(
                value: true,
                groupValue: true,
                onChanged: (value) {
                  log("Value: $value");
                },

                // child: Radio(
                //     value: switchListTileValue,
                //     groupValue: switchListTileValue,
                //     toggleable: true,
                //     onChanged: (value) {
                //       log("$switchListTileValue  $value");
                //       // setState(() {
                //       //   switchListTileValue = value!;
                //       // });
                //     }),
              )
            ],
          )
        ],
      ),
    );
  }

  Container selectedBtn(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(left: 0.00015.toResponsive(context)),
      padding: EdgeInsets.only(left: 0.00008.toResponsive(context)),
      height: 0.05.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: btnlistOrder.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  btnTapIndex = index;
                });
              },
              child: Container(
                height: 0.8.h(context),
                width: 0.27.w(context),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: btnTapIndex == index ? secondaryColors : primary,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Text(
                  btnlistOrder[index],
                  style: myTextStyle(
                      btnTapIndex != index ? secondaryColors : primary,
                      0.0134.toResponsive(context),
                      " Roboto"),
                )),
              ),
            );
          }),
    );
  }

  SizedBox seaechBar(BuildContext context) {
    return SizedBox(
      height: 0.065.h(context),
      width: 1.0.w(context),
      child: Row(
        children: [
          Container(
            height: 0.06.h(context),
            width: 0.57.w(context),
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
                  height: 0.1.h(context),
                  width: 0.1.w(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/searchicons.png"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search by table or category",
                        hintStyle: TextStyle(
                            color: textColor,
                            fontSize: 0.012.toResponsive(context),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito"),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 0.03.w(context),
          ),
          Container(
            padding: EdgeInsets.only(left: 0.015.toResponsive(context)),
            height: 0.80.h(context),
            width: 0.324.w(context),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "veg only",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Radio(
                groupValue: selectedRadio,
                value: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio != value!;

                    log(selectedRadio.toString());
                  });
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
