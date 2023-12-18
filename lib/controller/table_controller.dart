// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../model/tables_model.dart';

class TableController extends GetxController {
  var products = <TableModels>[].obs;

  getTables() async {
    log("GEt tables called");
    var url = Uri.parse(Url.resturentApiEndPoint);
    var response = await http.get(url);

    List data = jsonDecode(response.body);
    products.addAll(data.map((post) => TableModels.fromjson(post)).toList());
  }
}
