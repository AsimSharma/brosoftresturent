import 'package:brosoftresturent/controller/products_controller.dart';
import 'package:brosoftresturent/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_items.dart';
import '../../utils/app_style.dart';
import 'dart:developer';

import 'models/btn_selected_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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

  @override
  Widget build(BuildContext context) {
    var filterProduct = _filteredProducts();

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: 1.0.h(context),
                width: 1.0.w(context),
                padding: EdgeInsets.only(
                  left: 0.02.toResponsive(context),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.01.h(context),
                      ),
                      //headerSections
                      hederSections(context),
                      SizedBox(
                        height: 0.02.h(context),
                      ),
                      textSections(context),
                      SizedBox(
                        height: 0.02.h(context),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 0.06.h(context),
                            width: 0.6.w(context),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2.2,
                                style: BorderStyle.solid,
                                color: textColor,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 0.1.h(context),
                                  width: 0.1.w(context),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/searchicons.png"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 0.7.w(context),
                                    height: 0.06.h(context),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Search by table or category",
                                        hintStyle: myTextStyle(
                                            textColor,
                                            0.011.toResponsive(context),
                                            "Roboto"),
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
                          Expanded(
                            child: Row(children: [
                              Text(
                                "veg only",
                                style: myTextStyle(textColor,
                                    0.015.toResponsive(context), "Roboto"),
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
                              )
                            ]),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //btnSelected
                      Container(
                        padding: EdgeInsets.zero,
                        height: 50,
                        width: 1.0.w(context),
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
                                        height: 40,
                                        width: 0.2.w(context),
                                        margin: const EdgeInsets.only(left: 1),
                                        decoration: BoxDecoration(
                                            color: btnTapIndex == index
                                                ? secondaryColors
                                                : primary,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Center(
                                            child: Text(
                                          btnlistOrder[index],
                                          style: myTextStyle(
                                              btnTapIndex != index
                                                  ? secondaryColors
                                                  : primary,
                                              0.0095.toResponsive(context),
                                              " Roboto"),
                                        )),
                                      ),
                                    ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.005.h(context),
                      ),
                      //ui filter
                      SizedBox(
                        width: 1.0.w(context),
                        height: 0.61.h(context),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: filterProduct.length,
                          itemBuilder: (context, index1) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(filterProduct[index1].productName),
                                SizedBox(
                                  height: 200,
                                  width: 1.0.w(context),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: filterProduct[index1]
                                          .productItem
                                          .length,
                                      itemBuilder: (context, index2) {
                                        return Card(
                                          color: Colors.grey[300],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.abc),
                                              Text(filterProduct[index1]
                                                  .productItem[index2]
                                                  .itemName
                                                  .capitalize
                                                  .toString()),
                                              Text(filterProduct[index1]
                                                  .productItem[index2]
                                                  .rs
                                                  .toString()
                                                  .capitalize
                                                  .toString()),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ]),
              ),
              Positioned(
                  bottom: 10,
                  child: Row(
                    children: [
                      Text("helooo"),
                      Text("helooo"),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Row textSections(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Table",
              style:
                  myTextStyle(textColor, 0.013.toResponsive(context), "Roboto"),
            ),
            Text(
              "2A",
              style: myTextStyle(
                  secondaryColors, 0.015.toResponsive(context), "Roboto"),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Guest",
              style:
                  myTextStyle(textColor, 0.013.toResponsive(context), "Roboto"),
            ),
            Text(
              "5",
              style: myTextStyle(
                  secondaryColors, 0.015.toResponsive(context), "Roboto"),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "OrderNumber",
              style:
                  myTextStyle(textColor, 0.013.toResponsive(context), "Roboto"),
            ),
            Text(
              "150",
              style: myTextStyle(
                  secondaryColors, 0.015.toResponsive(context), "Roboto"),
            )
          ],
        )
      ],
    );
  }

  SizedBox hederSections(BuildContext context) {
    return SizedBox(
      height: 0.06.h(context),
      width: 1.0.w(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 0.03.h(context),
            width: 0.03.w(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Back Icon.png"))),
          ),
          Text(
            "Selected Order",
            style:
                myTextStyle(textColor, 0.015.toResponsive(context), "Roboto"),
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

//mnjkhk