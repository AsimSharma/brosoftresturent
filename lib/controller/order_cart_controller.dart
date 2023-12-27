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

  addtoCart(
    String tableName,
    int totalGuest,
    int orderNo,
    int totalprices,
    List<ProductItem> productItems,
  ) {
    OrderCart orderCart = OrderCart(
      tableName: tableName,
      totalGuest: totalGuest,
      orderNo: orderNo,
      totalprices: totalprices,
      productItems: productItems,
    );

    log(productItems[0].id.toString());

    // for (var data in ordercart) {
    //   log(data.toString());
    //   int index = data.productItems
    //       .indexWhere((i) => i.id == productItems[0].id.toString());
    //   log(index.toString());

    //   if (index != -1) {
    //     // updateProduct(product, product.qty + 1);
    //     ordercart.add(orderCart);
    //     log("heloloo");
    //   } else {
    //     ordercart.add(orderCart);
    //   }
    // }

    ordercart.add(orderCart);
  }

  int getTotalItems() {
    int total = 0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        total += iteem.quantity;
      }
    }

    return total;
  }

  double calculateTotalPrices() {
    double totalPrices = 0.0;
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        totalPrices += iteem.prices * iteem.quantity;
      }
    }
    return totalPrices;
  }

  String getProductsID() {
    var productsId = "";
    for (var item in ordercart) {
      for (var iteem in item.productItems) {
        productsId = iteem.id;
      }
    }
    return productsId;
  }

// updateProduct(product, qty) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     cart[index].qty = qty;
//     if (cart[index].qty == 0)
//       removeProduct(product);

//     calculateTotal();
//     notifyListeners();
//   }

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
