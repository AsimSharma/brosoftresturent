import 'package:brosoftresturent/model/ordercartmodel.dart';
import 'package:brosoftresturent/model/product_items.dart';

import 'package:get/get.dart';
import 'dart:developer';

// import "package:http/http.dart" as http;

class OrDerController extends GetxController {
  var isLooding = false.obs;
  var ordercart = <OrderCart>[].obs;

//add order to the database
  // addOrder(
  //     {required ProductItemo products,
  //     required String tableName,
  //     required int guestNumber,
  //     required int orderNo,
  //     required int totalPrices,
  //     required int totalItem}) async {
  //   isLooding = true.obs;
  //   try {
  //     log("this addOrder in cart");

  //     OrderCart ordercart = OrderCart(
  //         tableName: tableName,
  //         guest: guestNumber,
  //         orderNo: orderNo,
  //         totalprices: totalPrices,
  //         totalItem: totalItem,
  //         productItems: [products]);

  //     var data = jsonEncode(ordercart.tojson());
  //     var uri = Uri.parse(Url.ordercart);

  //     http.Response res = await http.post(
  //       uri,
  //       body: data,
  //     );

  //     log(data.toString());
  //     log(res.body.toString());
  //   } catch (err) {
  //     log(err.toString());
  //   } finally {
  //     isLooding = false.obs;
  //   }
  // }

  addtoCart11(String tableName, int totalGuest, int orderNo, int totalprices,
      List<ProductItem> productItems, String id) {
    OrderCart neworderCart = OrderCart(
      tableName: tableName,
      totalGuest: totalGuest,
      orderNo: orderNo,
      totalprices: totalprices,
      productItems: productItems,
    );

    ordercart.add(neworderCart);

    // for (var data in ordercart) {
    //   for (var dataa in data.productItems) {
    //     log(data.toString());
    //     int index = data.productItems
    //         .indexWhere((i) => i.id == productItems[0].id.toString());
    //     log(index.toString());

    //     if (index != -1) {
    //       // updateProduct(product, product.qty + 1);
    //       ordercart.add(neworderCart);
    //       log("heloloo");
    //     } else {
    //       ordercart.add(neworderCart);
    //     }
    //   }
    // }
    getTotalItems();
    update();
  }

  int getTotalItems() {
    int total = 0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        total += iteem.quantity;
      }
    }
    update();

    return total;
  }

  double calculateTotalPrices() {
    double totalPrices = 0.0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        totalPrices += iteem.prices * iteem.quantity;
        update();
      }
    }
    update();
    return totalPrices;
  }

  String getProductsID() {
    var productsId = "";
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        productsId = iteem.id;
      }
    }
    update();
    return productsId;
  }

  clearCart() {
    ordercart = <OrderCart>[].obs;
    update();
    log(ordercart.length.toString());
  }

  double grandTotalPrices() {
    double totalPrices = calculateTotalPrices();

    double serviceTax = getServicTax();
    double vaTax = getVatTax();

    double grandTotalPrices = totalPrices + serviceTax + vaTax;

    log(totalPrices.toString());
    update();
    return grandTotalPrices.roundToDouble();
  }

  double getServicTax() {
    double totalPrices = calculateTotalPrices();
    double serviceTaxCalc = totalPrices * 13 / 100;
    update();
    return serviceTaxCalc;
  }

  double getVatTax() {
    //vat tax 13 %
    double totalPrices = calculateTotalPrices();
    double vattaxCalc = totalPrices * 13 / 100;
    update();
    return vattaxCalc;
  }
}
