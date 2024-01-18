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

  /////CustomizeincreaseCFoodQuantity
  increaseCFoodQuantity(int fid) {
    for (int i = 0; i < productList.length; i++) {
      for (int j = 0; j < productList[i].foodItems.length; j++) {
        if (productList[i].foodItems[j].fid == fid) {
          productList[i].foodItems[j].customizeQuantity++;
        }
      }
    }

    update();
    productList.refresh();
  }

  ///CustomizedecreaseCFoodQuantity

  decreaseCFoodQuantity(int fid) {
    for (int i = 0; i < productList.length; i++) {
      for (int j = 0; j < productList[i].foodItems.length; j++) {
        if (productList[i].foodItems[j].fid == fid) {
          if (productList[i].foodItems[j].customizeQuantity > 0) {
            productList[i].foodItems[j].customizeQuantity--;
          } else {
            productList[i].foodItems[j].customizeQuantity = 0;
          }
        }
      }
    }

    update();
    productList.refresh();
  }

  totaFoodsPrices(int id) {
    for (int i = 0; i < productList.length; i++) {
      for (int j = 0; j < productList[i].foodItems.length; j++) {
        if (productList[i].foodItems[j].fid == id) {
          productList[i].foodItems[j].customizePrices =
              (productList[i].foodItems[j].customizeQuantity) *
                  (productList[i].foodItems[j].prices);

          log(" this is customize prices${productList[i].foodItems[j].customizePrices.toString()}");
        }
      }
    }

    update();
    productList.refresh();
  }
}
