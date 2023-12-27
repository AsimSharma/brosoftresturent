import 'package:brosoftresturent/model/ordercartmodel.dart';
import 'package:brosoftresturent/model/product_items.dart';

import 'package:get/get.dart';
import 'dart:developer';

// import "package:http/http.dart" as http;

class OrDerController extends GetxController {
  var isLooding = false.obs;
  var ordercart = <OrderCart>[].obs;

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

  addtoCart(String tableName, int totalGuest, int orderNo, int totalprices,
      List<ProductItem> productItems, String id) {
    OrderCart orderCart = OrderCart(
      tableName: tableName,
      totalGuest: totalGuest,
      orderNo: orderNo,
      totalprices: totalprices,
      productItems: productItems,
    );

    ordercart.add(orderCart);
    // for (var data in ordercart) {
    //   for (var dataa in data.productItems) {
    //     // final existingIndex =
    //     //     data.productItems.indexWhere((item) => item.id == id);

    //     // if (existingIndex != -1) {
    //     //   data.productItems[existingIndex].quantity += 1;

    //     //   log("only add items ${data.productItems[existingIndex].quantity}");
    //     // } else {
    //     //   ordercart.add(orderCart);
    //     //   log("ADD NEW ITEMS");
    //     // }

    //     ordercart.add(orderCart);
    //     log("ADD NEW ITEMS");
    //   }
    // }
  }

  int getTotalItems() {
    int total = 0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        total += iteem.quantity;
        log(" this tootal item in cart ${iteem.quantity}");
      }
    }

    return total;
  }

  int calculateTotalPrices() {
    int totalPrices = 0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        totalPrices += iteem.prices * iteem.quantity;
        log("$totalPrices");
      }
    }
    return totalPrices;
  }

  String getProductsID() {
    var productsId = "";
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        productsId = iteem.id;
        log("this is product id ${productsId.toString()}");
      }
    }
    return productsId;
  }

  increment() {}

  // void increaseItemQuantity(CartItem item) {
  //   final index = cartItems.indexOf(item);
  //   if (index != -1) {
  //     cartItems[index].quantity++;
  //   }
  // }

  // void decreaseItemQuantity(CartItem item) {
  //   final index = cartItems.indexOf(item);
  //   if (index != -1 && cartItems[index].quantity > 1) {
  //     cartItems[index].quantity--;
  //   }
  // }
}
