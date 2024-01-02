import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/remote_products.dart';
import 'package:http/http.dart' as http;

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

class RemoteProductCtrl extends GetxController {
  var productList = <Foods>[].obs;

  var isLooding = false.obs;
  getRemoteProductsItems() async {
    isLooding = true.obs;
    try {
      var url = Uri.parse(Url.remoteProductsUrl);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      productList.addAll(data.map((items) => Foods.fromJson(items)).toList());
      log(data.toString());
    } catch (err) {
      log(err.toString());
    } finally {
      isLooding = false.obs;
    }
  }
}
