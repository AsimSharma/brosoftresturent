import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

import "package:http/http.dart" as http;

import '../model/ordercartmodel.dart';

class OrDerController extends GetxController {
  addOrder(
      {required ProductItemo products,
      required String tableName,
      required int guestNumber,
      required int orderNo,
      required int totalPrices,
      required int totalItem}) async {
    try {
      log("this addOrder in cart");

      OrderCart ordercart = OrderCart(
          tableName: tableName,
          guest: guestNumber,
          orderNo: orderNo,
          totalprices: totalPrices,
          totalItem: totalItem,
          productItems: [products]);

      var data = jsonEncode(ordercart.tojson());
      var uri = Uri.parse(Url.ordercart);

      http.Response res = await http.post(
        uri,
        body: data,
      );

      log(data.toString());
      log(res.body.toString());
    } catch (err) {
      log(err.toString());
    }
  }
}
