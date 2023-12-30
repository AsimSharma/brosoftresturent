import 'package:brosoftresturent/controller/order_cart_controller.dart';

import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/images_path_store.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/table/models/images.dart';
import 'package:brosoftresturent/view/SelectedOrder/confirm_selected_order.dart';
import 'package:brosoftresturent/view/widgets/toast_message.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../controller/products_controller.dart';
import '../../model/order_models.dart';
import '../../model/product_items.dart';
import '../table/models/btn_selected_model.dart';

import 'dart:developer';

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
  // Declare this variable
  bool selectedRadio = false;
  int btnTapIndex = 0;
  final productsController = Get.put(ProductsController());

  @override
  void initState() {
    Get.put(ProductsController());
    _init();
    super.initState();
  }

  _init() async {
    await productsController.getProductsItems();
    _filteredProducts();
    btnTapIndex = 0;
  }

  List<Products> _filteredProducts() {
    if (btnTapIndex == 0) {
      return productsController.productList;
    } else {
      var selectedCategory = btnlistOrder[btnTapIndex];
      return productsController.productList
          .where((product) => product.productName == selectedCategory)
          .toList();
    }
  }

  final orderCartController = Get.put(OrDerController());

  final orderCartCtrl = Get.put(OrderCartCtrl());

  bool addOrder = false;

  @override
  Widget build(BuildContext context) {
    var filterProduct = _filteredProducts();

    return Scaffold(
      bottomNavigationBar: bottomCartBar(context),
      body: SafeArea(
        child: Obx(
          () => Container(
            height: 0.92.h(context),
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 0.012.toResponsive(context),
              right: 0.012.toResponsive(context),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //headerSections
              hederSections(context),
              SizedBox(
                height: 0.004.h(context),
              ),
              textSections(
                  context, widget.tablename, widget.totalGuest, widget.oderNo),
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

              productsController.isLooding == true.obs
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : listviewProducts(context, filterProduct)
            ]),
          ),
        ),
      ),
    );
  }

  Container bottomCartBar(BuildContext context) {
    return Container(
      height: 0.08.h(context),
      width: 1.0.w(context),
      margin: EdgeInsets.all(0.002.toResponsive(context)),
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
              orderCartController.ordercart.isEmpty
                  ? showToast(context, "Add something in cart")
                  : Get.to(const ConfirmOrderScreen());
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
                      textColor, 0.015.toResponsive(context), "Roboto"),
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

  SizedBox listviewProducts(
      BuildContext context, List<Products> filterProduct) {
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
                filterProduct[index1].productName,
                style: myTextStyle(
                    secondaryColors, 0.015.toResponsive(context), "Roboto"),
              ),
              SizedBox(
                height: 0.0125.h(context),
              ),
              SizedBox(
                height: 0.35.h(context),
                width: 1.0.w(context),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterProduct[index1].productItem.length,
                    itemBuilder: (context, index2) {
                      var productItem =
                          filterProduct[index1].productItem[index2];
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
                                  child: Image.asset(productItem.veg == false
                                      ? AppImages.novegImage
                                      : AppImages.vegImages),
                                ),
                                Text(
                                  productItem.name.capitalize.toString(),
                                  style: TextStyle(
                                      color: secondaryColors,
                                      fontSize: 0.015.toResponsive(context),
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
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
                                      productItem.customize == true
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
                                productItem.quantity == 0
                                    ? InkWell(
                                        onTap: () async {
                                          productsController.incrementQuantity(
                                              productItem.id);

                                          log(productItem.quantity.toString());

                                          orderCartCtrl.selectorder.add(
                                              OrderItem(
                                                  fname: productItem.name,
                                                  ftableName: widget.tablename,
                                                  fprices: productItem.prices,
                                                  quantity:
                                                      productItem.quantity,
                                                  fcustomize:
                                                      productItem.customize,
                                                  fveg: productItem.veg,
                                                  note: "",
                                                  foodquantity:
                                                      productItem.quantity,
                                                  spicyLevel: ""));

                                          // orderCartController.addtoCart11(
                                          //     "2A",
                                          //     5,
                                          //     189,
                                          //     productItem.prices,
                                          //     [
                                          //       filterProduct[index1]
                                          //           .productItem[index2],
                                          //     ],
                                          //     productItem.id);

                                          Order neworder = Order(
                                              orderId: widget.oderNo.toString(),
                                              tableName: widget.tablename,
                                              time: "",
                                              sheduleFor: "",
                                              isComplete: false,
                                              orderNo: widget.oderNo,
                                              totalGuest: widget.totalGuest,
                                              order: List.from(
                                                  orderCartCtrl.selectorder),
                                              addOrder: []);

                                          orderCartCtrl.postorder(
                                              order: neworder);

                                          log(orderCartCtrl
                                              .getOrder("2")
                                              .toString());

                                          Order? dtta =
                                              await orderCartCtrl.getOrder('2');
                                          log(dtta!.tableName);
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
                                        height: 0.048.h(context),
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
                                                    log("decrement");
                                                    productsController
                                                        .decrementQuantity(
                                                            productItem.id);
                                                  },
                                                  child: Container(
                                                    height: 1.0.h(context),
                                                    width: 0.063.w(context),
                                                    child: Image.asset(
                                                        "assets/images/subwhite.png"),
                                                  )),
                                              Text(
                                                productItem.quantity.toString(),
                                                style: TextStyle(
                                                    color: primary,
                                                    fontSize: 0.013
                                                        .toResponsive(context),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Roboto"),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    productsController
                                                        .incrementQuantity(
                                                            productItem.id);
                                                  },
                                                  child: Container(
                                                    height: 1.0.h(context),
                                                    width: 0.063.w(context),
                                                    child: Image.asset(
                                                        "assets/images/addwhite.png"),
                                                  )),
                                            ]),
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
                      decoration: InputDecoration(
                        hintText: "Search by table or category",
                        hintStyle: myTextStyle(
                            textColor, 0.011.toResponsive(context), "Roboto"),
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

  Container textSections(
      BuildContext context, String tableName, int guestNumber, int oderNo) {
    return Container(
      height: 0.05.h(context),
      margin: EdgeInsets.only(left: 0.0015.toResponsive(context)),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Table ",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                tableName,
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Guest ",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                guestNumber.toString(),
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Order No",
                style: myTextStyle(
                    textColor, 0.013.toResponsive(context), "Roboto"),
              ),
              Text(
                oderNo.toString(),
                style: TextStyle(
                    color: secondaryColors,
                    fontSize: 0.015.toResponsive(context),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  Container hederSections(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(top: 0.001.toResponsive(context)),
      color: primary,
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 0.05.h(context),
              width: 0.05.w(context),
              child: Container(
                height: 0.025.h(context),
                width: 0.02.w(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Back Icon.png"))),
              ),
            ),
          ),
          Text(
            "Selected Order",
            style: TextStyle(
                color: textColor,
                fontSize: 0.016.toResponsive(context),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400),
          ),
          Container(
            height: 0.06.h(context),
            width: 0.06.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/notification.png"))),
          ),
        ],
      ),
    );
  }
}
