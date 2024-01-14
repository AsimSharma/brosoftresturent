import 'package:brosoftresturent/model/remote_order_models.dart';

import 'package:brosoftresturent/model/remote_products.dart';

import 'package:get/get.dart';
import 'dart:developer';

//this is our cart
class OrDerController extends GetxController {
  var isLooding = false.obs;
  RxList<Order> addItems = <Order>[].obs;

  addItemsOnCart(
    FoodItems foodItems,
    String tableName,
  ) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == foodItems.fid) {
        hasItem = true;
      }
    }

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == foodItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity + 1,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);

      //update
    } else {
      Order newOrdersItemss = Order(
          fid: foodItems.fid,
          foodName: foodItems.fname,
          tableName: tableName,
          quantity: foodItems.quantity,
          price: foodItems.prices,
          note: "",
          foodQuantity: "",
          spicyLevel: "",
          addons: [""],
          isCustomisable: foodItems.isCustomize,
          isVeg: foodItems.isVeg);

      addItems.add(newOrdersItemss);
    }

    update();
  }

  increaseFoodQuanity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity + 1,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);
    } else {
      log("Product not Found");
    }
    update();
  }

  decFoodQuanity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }
    log("$hasItem");
    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity - 1,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);
    } else {
      log("Product not Found");
    }

    update();
  }

  int getTotalItems() {
    int total = 0;
    for (Order item in addItems) {
      total += item.quantity;
    }
    update();
    return total;
  }

  double calculateTotalPrices() {
    double totalPrices = 0.0;

    for (Order item in addItems) {
      totalPrices += item.price * item.quantity;
      update();
    }
    update();
    return totalPrices;
  }

  //getIndivisualPrices
  double calculateIndivisualPrices(Order order) {
    double indivisualPrices = 0.0;

    for (Order item in addItems) {
      if (item.fid == order.fid) {
        indivisualPrices += item.price * item.quantity;
        update();
      }
    }
    return indivisualPrices;
  }

  clearCart() {
    addItems = <Order>[].obs;
    update();
    log(addItems.length.toString());
  }

  double grandTotalPrices() {
    double totalPrices = calculateTotalPrices();

    double serviceTax = getServicTax();
    double vaTax = getVatTax();

    double grandTotalPrices = totalPrices + serviceTax + vaTax;

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

  //
  increaseCartQuantity(Order order) {
    bool hasItems = false;
    for (Order item in addItems) {
      if (item.fid == order.fid) {
        hasItems = true;
      }
    }

    if (hasItems) {
      var item = addItems.indexWhere((p0) => p0.fid == order.fid);
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity + 1,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);
    }
    update();
  }

  //decrease
  decraseCartQuantity(Order order) {
    bool hasItems = false;
    for (Order item in addItems) {
      if (item.fid == order.fid) {
        hasItems = true;
      }
    }

    if (hasItems) {
      var item = addItems.indexWhere((p0) => p0.fid == order.fid);
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity - 1,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);
    }
    update();
  }

  //addNote
  //Todo make add note methods and updateNote
  isAddedNote(Order order) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == order.fid) {
        hasItem = true;
      }
    }
    log("HasItem $hasItem");
    var index = addItems.indexWhere((p0) => p0.fid == order.fid);
    if (addItems[index].isAdded == false) {
      addItems[index].isAdded = true;
    } else {
      addItems[index].isAdded = false;
    }

    update();
    addItems.refresh();

    // var index = addItems.indexWhere((p0) => p0.fid == order.fid);
  }

  updateNote(String noteText, Order order) {
    var index = addItems.indexWhere((p0) => p0.fid == order.fid);
    addItems[index].note = noteText;

    update();
    addItems.refresh();
  }

  //
  addCustomizeItemsInCart(FoodItems foodItems, String foodQuantity,
      String spicyLevel, String addOns, String tableName) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == foodItems.fid) {
        hasItem = true;
      }
    }

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == foodItems.fid);
      log(" this is the index where Items  $item ");
      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: foodItems.customizeQuantity,
          price: foodItems.customizePrices,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg);

      //update
    } else {
      Order cusTomizeOrder = Order(
          fid: foodItems.fid,
          foodName: foodItems.fname,
          tableName: tableName,
          quantity: foodItems.customizeQuantity,
          price: foodItems.customizePrices,
          note: "",
          foodQuantity: foodQuantity,
          spicyLevel: spicyLevel,
          addons: [addOns],
          isCustomisable: foodItems.isCustomize,
          isVeg: foodItems.isVeg);

      addItems.add(cusTomizeOrder);

      update();
      addItems.refresh();
    }
  }

  //find quantityby id
  int findQuantity(int foodId) {
    int quantity = 0;
    for (int i = 0; i < addItems.length; i++) {
      if (addItems[i].fid == foodId) {
        quantity += addItems[i].quantity;
        update();
        // addItems.refresh();
        log("your quantity  $quantity");
      }
    }
    return quantity;
  }
}
