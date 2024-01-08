import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/remote_products.dart';
import 'package:http/http.dart' as http;

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

class RemoteProductCtrl extends GetxController {
  var productList = <Foods>[].obs;
  var quantity = 0.obs;
  var isAdded = false.obs;

  @override
  void onInit() {
    initilizedtotalQuantiry();
    super.onInit();
  }

  var isLooding = false.obs;
  getRemoteProductsItems() async {
    isLooding = true.obs;
    try {
      var url = Uri.parse(Url.remoteProductsUrl);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      productList = <Foods>[].obs;
      productList.addAll(data.map((items) => Foods.fromJson(items)).toList());
    } catch (err) {
      log(err.toString());
    } finally {
      isLooding = false.obs;
    }

    update();
    productList.refresh();
  }

  upDateIsAdded(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);

    productList[index1].foodItems[index2].isAdded = true;

    update();
    productList.refresh();
  }

  increaseFoodQuantity(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);

    productList[index1].foodItems[index2].totalQuantity++;
    update();
    productList.refresh();
  }

  decreaseFoodQuantity(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);

    if (productList[index1].foodItems[index2].totalQuantity > 0) {
      productList[index1].foodItems[index2].totalQuantity--;
    } else {
      productList[index1].foodItems[index2].totalQuantity = 0;
    }
    update();
    productList.refresh();
  }

  initilizedtotalQuantiry() {
    for (Foods item in productList) {
      for (FoodItems iteem in item.foodItems) {
        iteem.totalQuantity = 0;
        iteem.customizeQuantity = 0;
        iteem.customizePrices = 0;
      }
    }
    update();
  }

  //totalpricesCustomize
  totaFoodsPrices(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);
    productList[index1].foodItems[index2].customizePrices =
        (productList[index1].foodItems[index2].customizeQuantity) *
            (productList[index1].foodItems[index2].prices);
    update();
    productList.refresh();
  }

/////CustomizeincreaseCFoodQuantity
  increaseCFoodQuantity(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);

    productList[index1].foodItems[index2].customizeQuantity++;
    update();
    productList.refresh();
  }

  ///CustomizedecreaseCFoodQuantity

  decreaseCFoodQuantity(
    Foods foods,
    FoodItems foodsItem,
  ) {
    var index1 = productList.indexWhere((p0) => p0.id == foods.id);
    var index2 = productList[index1]
        .foodItems
        .indexWhere((element) => element.fid == foodsItem.fid);

    if (productList[index1].foodItems[index2].customizeQuantity > 0) {
      productList[index1].foodItems[index2].customizeQuantity--;
    } else {
      productList[index1].foodItems[index2].customizeQuantity = 0;
    }
    update();
    productList.refresh();
  }
}
