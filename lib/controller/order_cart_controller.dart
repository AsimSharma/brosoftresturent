import 'package:brosoftresturent/model/ordercartmodel.dart';

import 'package:brosoftresturent/model/remote_products.dart';

import 'package:get/get.dart';
import 'dart:developer';

// import "package:http/http.dart" as http;

class OrDerController extends GetxController {
  var isLooding = false.obs;
  var ordercart = <OrderCart>[].obs;
  var addItems = <FoodItems>[].obs;

  var tap = false.obs;

  var isAddedui = false.obs;

  // bool isAddedfun(ProductItem productItem) {
  //   bool hasItem = false;
  //   for (ProductItem item in addItems) {
  //     if (item.id == productItem.id) {
  //       hasItem = true;
  //     }
  //     return hasItem;
  //   }

  //   return true;
  // }

// kindly ChangeThe Product Modele
  addItemsOnCart(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (FoodItems item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = FoodItems(
          fid: addItems[item].fid,
          fname: addItems[item].fname,
          prices: addItems[item].prices,
          quantity: addItems[item].quantity + 1,
          isVeg: addItems[item].isVeg,
          isCustomize: addItems[item].isCustomize,
          isAdded: addItems[item].isAdded = true);

      tap = true.obs;
    } else {
      addItems.add(productItems);
    }

    update();

    for (FoodItems product in addItems) {
      log("   Name: ${product.fname}  Quantity:${product.quantity}");
    }
  }

  increaseQuanity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (FoodItems item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = FoodItems(
          fid: addItems[item].fid,
          fname: addItems[item].fname,
          prices: addItems[item].prices,
          quantity: addItems[item].quantity + 1,
          isVeg: addItems[item].isVeg,
          isCustomize: addItems[item].isCustomize,
          isAdded: addItems[item].isAdded = true);
    } else {
      log("Product not Found");
    }
    update();
  }

  decQuanity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (FoodItems item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = FoodItems(
          fid: addItems[item].fid,
          fname: addItems[item].fname,
          prices: addItems[item].prices,
          quantity: addItems[item].quantity > 0
              ? addItems[item].quantity - 1
              : addItems[item].quantity,
          isVeg: addItems[item].isVeg,
          isCustomize: addItems[item].isCustomize,
          isAdded: addItems[item].isAdded = true);
    } else {
      log("Product not Found");
    }

    update();
  }

  int getTotalItems() {
    int total = 0;
    for (FoodItems item in addItems) {
      total += item.quantity;
    }
    update();
    return total;
  }

  double calculateTotalPrices() {
    double totalPrices = 0.0;

    for (FoodItems item in addItems) {
      totalPrices += item.prices * item.quantity;
      update();
    }
    update();
    return totalPrices;
  }

  clearCart() {
    addItems = <FoodItems>[].obs;
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
