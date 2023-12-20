import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/product_items.dart';
import 'package:http/http.dart' as http;

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var productList = <Products>[].obs;

  //getProductsItems

  getProductsItems() async {
    var url = Uri.parse(Url.productsEndPoints);
    var response = await http.get(url);
    List data = jsonDecode(response.body);
    productList.addAll(data.map((items) => Products.fromJson(items)).toList());
    log(data.toString());
  }
}
