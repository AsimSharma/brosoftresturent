import 'package:brosoftresturent/view/OrderSelectPage/SelectedFoodItems/widgets/add_button.dart';
import 'package:brosoftresturent/view/widgets/shared/nepalirs.dart';
import 'package:flutter/material.dart';

import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/controller/remote_productcontroller.dart';
import 'package:brosoftresturent/model/remote_products.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/images_path_store.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/table/models/images.dart';

import '../../../widgets/shared/search_bar.dart';
import '../../widgets/table_order_info.dart';
import '../models/spicylevel_btn.dart';
import '../widgets/bottom_navigation_cart.dart';
import '../../widgets/header_app_bar.dart';

import 'package:get/get.dart';
import 'dart:developer';

import '../widgets/category_selected_btn.dart';
import '../widgets/inc_dec_btns.dart';

class SelectedOrder extends StatefulWidget {
  const SelectedOrder(
      {super.key,
      required this.tablename,
      required this.totalGuest,
      required this.orderNo,
      this.isAddOrders = false,
      this.orderId});

  final String tablename;
  final int totalGuest;
  final int orderNo;
  final bool isAddOrders;
  final String? orderId;

  @override
  State<SelectedOrder> createState() => _SelectedOrderState();
}

class _SelectedOrderState extends State<SelectedOrder> {
  bool switchListTileValue = false;
  bool selectedRadio = false;
  String searchValue = "";
  int btnTapIndex = 0;

  int btnTapIndexForSpicy = 0;

  final orderCartController = Get.put(OrDerController());
  final remoteProductCtrl = Get.put(RemoteProductCtrl());

  String selectedOption = 'Half';
  String addOnselected = 'Egg';
  List<String> btnlistOrder = ["All", "Momo", "Biryani", "Chaumin"];
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
                  orderCartController.clearCart();
                  Get.back();
                },
              ),
              SizedBox(
                height: 0.004.h(context),
              ),

              TableOrderInfo(
                tableName: widget.tablename,
                totalGuest: widget.totalGuest,
                orderNo: widget.orderNo,
              ),

              const Divider(),
              SizedBox(
                height: 0.008.h(context),
              ),

              searchBar(context),

              SizedBox(
                height: 0.015.h(context),
              ),
              //btnSelected
              categoryselectedbtn(context),
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

  Container categoryselectedbtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      padding: EdgeInsets.only(left: 0.0035.toResponsive(context)),
      height: 0.05.h(context),
      width: 1.0.w(context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: btnlistOrder.length,
          itemBuilder: (context, index) {
            return CategoryselectedBtn(
              btnTapIndex: btnTapIndex,
              index: index,
              onPressed: () {
                setState(() {
                  btnTapIndex = index;
                });
              },
            );
          }),
    );
  }

  Row searchBar(BuildContext context) {
    return Row(
      children: [
        SearchBarContainer(
          hintText: "Search by Cusine name",
          width: 0.62.w(context),
          onChangeValue: (value) {
            setState(() {
              searchValue = value;
            });
          },
        ),
        SizedBox(
          width: 0.012.w(context),
        ),
        Expanded(
          child:
              //Todo make radio icons Buttons not Radio buttons
              //and work on this funcnality
              Row(
            children: [
              Text(
                "veg only",
                style: myTextStyle(
                    textColor, 0.012.toResponsive(context), "Roboto"),
              ),
              Radio(
                groupValue: selectedRadio,
                value: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio != value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
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
                      var fooditems = filterProduct[index1].foodItems[index2];
                      var foods = filterProduct[index1];
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
                                InkWell(
                                  onTap: () {
                                    fooditems.isCustomize == true
                                        ? showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter setState) {
                                              return Obx(
                                                () => cusTomizedButtomSheet(
                                                    context,
                                                    setState,
                                                    filterProduct[index1],
                                                    fooditems,
                                                    tableName),
                                              );
                                            }),
                                          )
                                        : "";
                                  },
                                  child: Hero(
                                      tag: fooditems.fid,
                                      child: Image.asset(
                                          "${images['imageName']}")),
                                ),
                                SizedBox(
                                  height: 0.005.toResponsive(context),
                                ),
                                SizedBox(
                                  height: 0.015.toResponsive(context),
                                  width: 0.05.w(context),
                                  child: Image.asset(fooditems.isVeg == false
                                      ? AppImages.novegImage
                                      : AppImages.vegImages),
                                ),
                                Text(
                                  fooditems.fname.capitalize.toString(),
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
                                            fooditems.prices
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
                                      fooditems.isCustomize == true
                                          ? TextButton(
                                              onPressed: () {},
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
                                Obx(() => orderCartController
                                            .findQuantity(fooditems.fid) ==
                                        0
                                    ? AddButtons(
                                        orderCartController:
                                            orderCartController,
                                        fooditems: fooditems,
                                        tableName: tableName,
                                        backGroundColors: primary,
                                        height: 0.045.h(context),
                                        width: 0.23.w(context),
                                      )
                                    : IncDecButtons(
                                        orderCartController:
                                            orderCartController,
                                        fooditems: fooditems,
                                        backGroungColor: secondaryColors,
                                      )),
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

  Container cusTomizedButtomSheet(BuildContext context, StateSetter setState,
      Foods foods, FoodItems foodItems, String tableName) {
    double customizePrices;
    // if (selectedOption == "Half") {
    //   customizePrices = foodItems.customizePrices / 2.toDouble();
    //   log('This is CustomizePrices: ${customizePrices.toString()}');
    // } else {
    //   customizePrices = foodItems.customizePrices.toDouble();
    //   log('This is CustomizePrices: ${customizePrices.toString()}');
    // }

    final orderCartCtrl = Get.find<OrDerController>();

    return Container(
      height: 0.97.h(context),
      width: 1.0.w(context),
      child: Stack(children: [
        Positioned(
            bottom: 0.112.h(context),
            left: 0.005.toResponsive(context),
            right: 0.005.toResponsive(context),
            child: Container(
              width: 1.0.w(context),
              height: 0.07.h(context),
              decoration: const BoxDecoration(
                  color: secondaryColors,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(children: [
                //Todo do Same like this as
                //todo know the total quantity from id
                // total quantity=0 make add the ordercartIncQuantity
                //and Show increase decrease buttons
                //show from order cart not  remoteProducts
                orderCartCtrl.findCustomizeQuantity(foodItems.fid) == 0
                    ? AddCustomizrOrder(
                        orderCartController: orderCartController,
                        fooditems: foodItems,
                        tableName: tableName,
                        backGroundColors: primary,
                        height: 0.045.h(context),
                        width: 0.23.w(context),
                        spicyLevel: "max spicyLevel",
                        foodQuantity: "Half",
                        addOns: "very good",
                      )
                    : IncDecButtons(
                        orderCartController: orderCartController,
                        fooditems: foodItems,
                        backGroungColor:
                            const Color.fromARGB(255, 181, 111, 111),
                        isCustomize: true,
                      ),

                //prices
                Container(
                  height: 0.1.h(context),
                  width: 0.12.w(context),
                  margin: EdgeInsets.all(0.010.toResponsive(context)),
                  child: Center(
                      child: Row(
                    children: [
                      const NepaliRSw(),
                      SizedBox(
                        width: 0.0025.w(context),
                      ),
                      Text(
                        100.toString(),

                        // selectedOption == "Half"
                        //     ? (customizePrices + 50).toString()
                        //     : (customizePrices + 100).toString(),
                        style: TextStyle(
                          color: primary,
                          fontSize: 0.017.toResponsive(context),
                          fontWeight: FontWeight.w800,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  )),
                ),
                //add_orders_btns
                AddOrderBtns(
                  onPress: () {
                    orderCartController.addCustomizeItemsInCart(
                      foodItems,
                      selectedOption,
                      addOnselected,
                      "Medium",
                      tableName,
                    );

                    Get.back();
                  },
                )
              ]),
            )),
        Container(
          padding: EdgeInsets.only(
            left: 0.009.toResponsive(context),
            right: 0.009.toResponsive(context),
          ),
          height: 1.0.h(context),
          width: 1.0.w(context),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Center(
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 0.038.h(context),
                  )),
            ),

            SizedBox(
              height: 0.005.h(context),
            ),
            Container(
                height: 0.28.h(context),
                width: 1.0.w(context),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage("assets/images/customizedimages.png")),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.010.toResponsive(context)),
                        topLeft:
                            Radius.circular(0.010.toResponsive(context))))),
            SizedBox(
              height: 0.02.h(context),
            ),
            Row(
              children: [
                foodItems.isVeg
                    ? Image.asset("assets/images/Veg Icon.png")
                    : Image.asset("assets/images/Non-veg Tag.png"),
                SizedBox(
                  width: 0.02.w(context),
                ),
                Text(
                  foodItems.fname,
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Choose one (1/1)*",
                style: TextStyle(
                    color: textColor,
                    fontSize: 0.016.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800),
              ),
            ),

            //Half radio
            SizedBox(
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
                      Text(
                        " ${foodItems.prices / 2.round()}".toString(),
                        style: myTextStyle(secondaryColors,
                            0.015.toResponsive(context), "Roboto"),
                      ),
                      Radio<String>(
                        value: 'Half',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            //full chiiseOn
            SizedBox(
              height: 0.051.h(context),
              width: 1.0.w(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Full",
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
                      Text(
                        foodItems.prices.toString(),
                        style: myTextStyle(secondaryColors,
                            0.015.toResponsive(context), "Roboto"),
                      ),
                      Radio<String>(
                        value: 'full',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Add On",
                style: TextStyle(
                    color: textColor,
                    fontSize: 0.016.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800),
              ),
            ),

            //Eggg
            SizedBox(
              height: 0.051.h(context),
              width: 1.0.w(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Egg",
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
                      Text(
                        "50",
                        style: myTextStyle(secondaryColors,
                            0.015.toResponsive(context), "Roboto"),
                      ),
                      Radio<String>(
                        value: 'Egg',
                        groupValue: addOnselected,
                        onChanged: (value) {
                          setState(() {
                            addOnselected = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 0.051.h(context),
              width: 1.0.w(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mushroom",
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
                      Text(
                        "100",
                        style: myTextStyle(secondaryColors,
                            0.015.toResponsive(context), "Roboto"),
                      ),
                      Radio<String>(
                        value: 'Mushroom',
                        groupValue: addOnselected,
                        onChanged: (value) {
                          setState(() {
                            addOnselected = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 0.06.h(context),
              width: 1.0.w(context),
            ),
            //SpicyLevel

            SizedBox(
              height: 0.025.h(context),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Spicy Level",
                style: TextStyle(
                    color: textColor,
                    fontSize: 0.016.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 0.005.h(context),
            ),

            SizedBox(
              height: 0.055.h(context),
              width: 1.0.w(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: spicylevelbtn.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(
                        () {
                          btnTapIndexForSpicy = index;
                        },
                      );
                    },
                    child: Container(
                      height: 0.035.h(context),
                      width: 0.3.w(context),
                      margin: EdgeInsets.only(
                          left: index == 0
                              ? 0.0.toResponsive(context)
                              : 0.01.toResponsive(context)),
                      decoration: BoxDecoration(
                          color: btnTapIndexForSpicy == index
                              ? Colors.orange
                              : primary,
                          border: Border.all(
                              color: btnTapIndexForSpicy == index
                                  ? Colors.orange
                                  : primary,
                              width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        spicylevelbtn[index],
                        style: TextStyle(
                            color: btnTapIndexForSpicy == index
                                ? primary
                                : textColor),
                      )),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      ]),
    );
  }
}

class AddOrderBtns extends StatelessWidget {
  const AddOrderBtns({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 0.1.h(context),
        width: 0.23.w(context),
        margin: EdgeInsets.all(0.010.toResponsive(context)),
        decoration: const BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: const Center(child: Text("Add Order")),
      ),
    );
  }
}
