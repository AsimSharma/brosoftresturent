import 'package:brosoftresturent/controller/order_cart_controller.dart';
import 'package:brosoftresturent/model/ordercartmodel.dart';
import 'package:brosoftresturent/utils/app_style.dart';
import 'package:brosoftresturent/utils/images_path_store.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:brosoftresturent/view/table/models/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/products_controller.dart';
import '../../../../model/product_items.dart';
import '../../../order/models/btn_selected_model.dart';

import 'dart:developer';

class SelectedOrder extends StatefulWidget {
  const SelectedOrder({super.key});

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

  bool addOrder = false;

  @override
  Widget build(BuildContext context) {
    var filterProduct = _filteredProducts();

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 0.012.toResponsive(context),
            right: 0.012.toResponsive(context),
          ),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //headerSections
                hederSections(context),
                SizedBox(
                  height: 0.004.h(context),
                ),
                textSections(context),
                const Divider(),
                SizedBox(
                  height: 0.008.h(context),
                ),

                seaechBar(context),

                SizedBox(
                  height: 0.015.h(context),
                ),
                //btnSelected
                btnSelecteForItem(context),
                SizedBox(
                  height: 0.018.h(context),
                ),
                //ui filter
                listviewProducts(context, filterProduct)
              ]),
              bottomCartBar(context)
            ],
          ),
        ),
      ),
    );
  }

  Positioned bottomCartBar(BuildContext context) {
    return Positioned(
        bottom: 70,
        child: Container(
          height: 0.09.h(context),
          width: 0.92.w(context),
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
                  Text(
                    "5 items",
                    style: myTextStyle(
                        primary, 0.015.toResponsive(context), "Roboto"),
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
                      Text(
                        "680",
                        style: myTextStyle(
                            primary, 0.015.toResponsive(context), "Roboto"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 0.16.w(context),
              ),

              Container(
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
              )
            ],
          ),
        ));
  }

  SizedBox listviewProducts(
      BuildContext context, List<Products> filterProduct) {
    return SizedBox(
      width: 1.0.w(context),
      height: 0.65.h(context),
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
                                productItem.itemName.capitalize.toString(),
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
                                          productItem.rs
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
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Customiasble",
                                        style: myTextStyle(
                                            Colors.red,
                                            0.0125.toResponsive(context),
                                            "Roboto"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              productItem.customize == true
                                  ? Container(
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
                                                child: Image.asset(
                                                    "assets/images/addwhite.png")),
                                            Text(
                                              "2",
                                              style: TextStyle(
                                                  color: primary,
                                                  fontSize: 0.013
                                                      .toResponsive(context),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Roboto"),
                                            ),
                                            InkWell(
                                                child: Image.asset(
                                                    "assets/images/subwhite.png"))
                                          ]),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        orderCartController.addOrder(
                                            products: ProductItemo(
                                                itemName: productItem.itemName,
                                                rs: productItem.rs,
                                                customize:
                                                    productItem.customize,
                                                veg: productItem.veg),
                                            tableName: "2A",
                                            guestNumber: 5,
                                            orderNo: 130,
                                            totalPrices: 350,
                                            totalItem: 10);

                                        log("heloop ");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 0.020.toResponsive(context),
                                              right:
                                                  0.020.toResponsive(context)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: secondaryColors,
                                                  width: 2)),
                                          margin: EdgeInsets.only(
                                              left: 0.04.toResponsive(context),
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
                            ],
                          ),
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

  Container btnSelecteForItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 0.04.h(context),
      width: 1.0.w(context),
      // color: Colors.red,
      child: Row(
        children: [
          ...List.generate(
              btnlistOrder.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        btnTapIndex = index;
                        log(btnTapIndex.toString());
                      });
                    },
                    child: Container(
                      height: 0.5.h(context),
                      width: 0.22.w(context),
                      margin: const EdgeInsets.only(left: 1),
                      decoration: BoxDecoration(
                          color:
                              btnTapIndex == index ? secondaryColors : primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        btnlistOrder[index],
                        style: myTextStyle(
                            btnTapIndex != index ? secondaryColors : primary,
                            0.0095.toResponsive(context),
                            " Roboto"),
                      )),
                    ),
                  ))
        ],
      ),
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

  Container textSections(BuildContext context) {
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
                "2A",
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
                "5",
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
                "150",
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
            child: Container(
              height: 0.03.h(context),
              width: 0.03.w(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Back Icon.png"))),
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
