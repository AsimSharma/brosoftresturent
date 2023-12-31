import 'package:brosoftresturent/model/ordercartmodel.dart';
import 'package:brosoftresturent/model/product_items.dart';

import 'package:get/get.dart';
import 'dart:developer';

// import "package:http/http.dart" as http;

class OrDerController extends GetxController {
  var isLooding = false.obs;
  var ordercart = <OrderCart>[].obs;
  var addItems = <ProductItem>[].obs;

  var tap = false.obs;

// kindly ChangeThe Product Modele
  addItemsOnCart(
    ProductItem productItems,
  ) {
    bool hasItem = false;
    for (ProductItem item in addItems) {
      if (item.id == productItems.id) {
        hasItem = true;
        tap = true.obs;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.id == productItems.id);
      log(" this is the index where Items  $item ");
      addItems[item] = ProductItem(
        id: addItems[item].id,
        name: addItems[item].name,
        prices: addItems[item].prices,
        quantity: addItems[item].quantity + 1,
        veg: addItems[item].veg,
        customize: addItems[item].customize,
      );
    } else {
      addItems.add(productItems);
    }

    for (ProductItem product in addItems) {
      log("   Name: ${product.name}  Quantity:${product.quantity}");
    }
  }

  increaseQuanity(
    ProductItem productItems,
  ) {
    bool hasItem = false;
    for (ProductItem item in addItems) {
      if (item.id == productItems.id) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.id == productItems.id);
      log(" this is the index where Items  $item ");
      addItems[item] = ProductItem(
        id: addItems[item].id,
        name: addItems[item].name,
        prices: addItems[item].prices,
        quantity: addItems[item].quantity + 1,
        veg: addItems[item].veg,
        customize: addItems[item].customize,
      );
    } else {
      log("Product not Found");
    }
    update();
  }

  decQuanity(
    ProductItem productItems,
  ) {
    bool hasItem = false;
    for (ProductItem item in addItems) {
      if (item.id == productItems.id) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.id == productItems.id);
      log(" this is the index where Items  $item ");
      addItems[item] = ProductItem(
        id: addItems[item].id,
        name: addItems[item].name,
        prices: addItems[item].prices,
        quantity: addItems[item].quantity > 0
            ? addItems[item].quantity - 1
            : addItems[item].quantity,
        veg: addItems[item].veg,
        customize: addItems[item].customize,
      );
    } else {
      log("Product not Found");
    }

    update();
  }

  int getTotalItems() {
    int total = 0;
    for (ProductItem item in addItems) {
      total += item.quantity;
    }
    update();
    return total;
  }

  double calculateTotalPrices() {
    double totalPrices = 0.0;

    for (ProductItem item in addItems) {
      totalPrices += item.prices * item.quantity;
      update();
    }
    update();
    return totalPrices;
  }

  clearCart() {
    addItems = <ProductItem>[].obs;
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
