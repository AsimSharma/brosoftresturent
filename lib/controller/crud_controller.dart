import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/crud_models.dart';
import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CrudController extends GetxController {
  var demoProducts = <Cruddemo>[].obs;

  getDemoProducts() async {
    var uri = Uri.parse(Url.productsEndPoints);
    var response = await http.get(uri);
    List data = jsonDecode(response.body);

    demoProducts
        .addAll(data.map((dataItem) => Cruddemo.fromJson(dataItem)).toList());
    log(data.toString());
  }
}
