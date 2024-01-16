import 'dart:developer';

import 'package:brosoftresturent/model/remote_order_models.dart';

import 'package:brosoftresturent/model/remote_products.dart';

import 'package:get/get.dart';

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
          isVeg: addItems[item].isVeg,
          addedTime: DateTime.now());

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
          isVeg: foodItems.isVeg,
          addedTime: DateTime.now());

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

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);

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
          isVeg: addItems[item].isVeg,
          addedTime: DateTime.now());
    } else {}
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

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);

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
          isVeg: addItems[item].isVeg,
          addedTime: DateTime.now());
    } else {}

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
          isVeg: addItems[item].isVeg,
          addedTime: DateTime.now());
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
          isVeg: addItems[item].isVeg,
          addedTime: DateTime.now());
    }
    update();
  }

  //addNote
  //Todo make add note methods and updateNote
  // isAddedNote(Order order) {
  //   bool hasItem = false;
  //   for (Order item in addItems) {
  //     if (item.fid == order.fid) {
  //       hasItem = true;
  //     }
  //   }

  //   var index = addItems.indexWhere((p0) => p0.fid == order.fid);
  //   if (addItems[index].isAdded == false) {
  //     addItems[index].isAdded = true;
  //   } else {
  //     addItems[index].isAdded = false;
  //   }

  //   update();
  //   addItems.refresh();

  //   // var index = addItems.indexWhere((p0) => p0.fid == order.fid);
  // }

  updateNote(String noteText, int fid) {
    for (int i = 0; i < addItems.length; i++) {
      if (addItems[i].fid == fid) {
        addItems[i].note = noteText;
      }
    }

    update();
  }

  bool checkedNotes(int fid) {
    bool isAlreadyNote = false;
    for (int i = 0; i < addItems.length; i++) {
      if (addItems[i].fid == fid) {
        if (addItems[i].note.isNotEmpty) {
          isAlreadyNote = true;
        }
      }
    }
    return isAlreadyNote;
  }

  //find quantityby id
  int findQuantity(int foodId) {
    int quantity = 0;
    for (int i = 0; i < addItems.length; i++) {
      if (addItems[i].fid == foodId) {
        quantity += addItems[i].quantity;
        update();
      }
    }
    return quantity;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//customizeController

  addCustomizeItemsInCart(FoodItems foodItems, String foodQuantity,
      String spicyLevel, String addOns, String tableName) {
    // bool hasItem = false;
    // for (Order item in addItems) {
    //   if (item.fid == foodItems.fid) {
    //     hasItem = true;
    //   }
    // }

    // if (hasItem) {
    //   var item = addItems.indexWhere((p0) => p0.fid == foodItems.fid);

    //   addItems[item] = Order(
    //       fid: addItems[item].fid,
    //       foodName: addItems[item].foodName,
    //       tableName: addItems[item].tableName,
    //       quantity: addItems[item].quantity,
    //       price: addItems[item].price,
    //       note: addItems[item].note,
    //       foodQuantity: addItems[item].foodQuantity,
    //       spicyLevel: addItems[item].spicyLevel,
    //       addons: addItems[item].addons,
    //       isCustomisable: addItems[item].isCustomisable,
    //       isVeg: addItems[item].isVeg,
    //       addedTime: DateTime.now(),
    //       customizePrices: addItems[item].customizePrices,
    //       customizeQuantity: addItems[item].customizeQuantity + 1);

    //   //update
    // } else {

    log(" The Food Quantity :${foodItems.quantity} the foood Prices ${foodItems.quantity}");
    Order cusTomizeOrder = Order(
        fid: foodItems.fid,
        foodName: foodItems.fname,
        tableName: tableName,
        quantity: 0,
        price: 0,
        note: "",
        foodQuantity: foodQuantity,
        spicyLevel: spicyLevel,
        addons: [addOns],
        isCustomisable: foodItems.isCustomize,
        isVeg: foodItems.isVeg,
        addedTime: DateTime.now(),
        customizePrices: foodItems.prices,
        customizeQuantity: foodItems.quantity);

    addItems.add(cusTomizeOrder);

    update();
    addItems.refresh();
    // }
  }

//increasetheCustomizeQuantity
  increaseCustomizeQantity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);

      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg,
          customizeQuantity: addItems[item].customizeQuantity + 1,
          customizePrices: addItems[item].customizePrices,
          addedTime: DateTime.now());
    } else {}
    update();
  }

  decraseCustomizeQantity(
    FoodItems productItems,
  ) {
    bool hasItem = false;
    for (Order item in addItems) {
      if (item.fid == productItems.fid) {
        hasItem = true;
      }
    }

    if (hasItem) {
      var item = addItems.indexWhere((p0) => p0.fid == productItems.fid);

      addItems[item] = Order(
          fid: addItems[item].fid,
          foodName: addItems[item].foodName,
          tableName: addItems[item].tableName,
          quantity: addItems[item].quantity,
          price: addItems[item].price,
          note: addItems[item].note,
          foodQuantity: addItems[item].foodQuantity,
          spicyLevel: addItems[item].spicyLevel,
          addons: addItems[item].addons,
          isCustomisable: addItems[item].isCustomisable,
          isVeg: addItems[item].isVeg,
          customizeQuantity: addItems[item].customizeQuantity - 1,
          customizePrices: addItems[item].customizePrices,
          addedTime: DateTime.now());
    } else {}
    update();
  }

  //
  int findCustomizeQuantity(int foodId) {
    int customizeQuantity = 0;
    for (int i = 0; i < addItems.length; i++) {
      if (addItems[i].fid == foodId) {
        customizeQuantity += addItems[i].customizeQuantity;
        update();
      }
    }
    return customizeQuantity;
  }
}
