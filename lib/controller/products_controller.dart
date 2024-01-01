import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/product_items.dart';
import 'package:http/http.dart' as http;

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var productList = <Products>[].obs;
  var selectedCategory = "All".obs;
  var isLooding = false.obs;
  var quantity = 0.obs;

  var isAddes = false.obs;

  getProductsItems() async {
    isLooding = true.obs;
    try {
      var url = Uri.parse(Url.productsEndPoints);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      productList
          .addAll(data.map((items) => Products.fromJson(items)).toList());
      log(data.toString());
    } catch (err) {
      log(err.toString());
    } finally {
      isLooding = false.obs;
    }
  }

  incrementQuantity(String id) {
    for (var product in productList) {
      for (var productItem in product.productItem) {
        if (productItem.id == id) {
          productItem.quantity++;
          quantity.value = productItem.quantity;
          productList.refresh();
          update();
        }
      }
    }
  }

  decrementQuantity(String id) {
    for (var product in productList) {
      for (var productItem in product.productItem) {
        if (productItem.id == id) {
          if (productItem.quantity > 0) {
            productItem.quantity--;
            quantity.value = productItem.quantity;
            productList.refresh();
            update();
          }
        }
      }
    }
  }

  isAddeui(String id) {
    for (var product in productList) {
      for (var productItem in product.productItem) {
        if (productItem.id == id) {
          productItem.isAdded = true;
          isAddes.value = productItem.isAdded;
        }
      }
    }
  }
}
