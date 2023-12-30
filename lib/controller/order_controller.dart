import 'dart:convert';
import 'dart:developer';
import 'package:brosoftresturent/model/order_models.dart';
import 'package:brosoftresturent/utils/url_constant.dart';

import 'package:get/get.dart';

import "package:http/http.dart" as http;

class OrderCartCtrl extends GetxController {
  var orderList = [].obs;
  var isLoading = false.obs;

  var selectorder = <OrderItem>[].obs;

  getAllProducts() async {
    var isLoading = false.obs;
    try {
      var isLoading = true.obs;
      var url = Uri.parse(Url.ordercart);
      http.Response response = await http.get(url);
      List data = jsonDecode(response.body);
      orderList.addAll(data.map((e) => Order.fromJson).toList());
      log(response.body);
    } catch (err) {
      log(err.toString());
    } finally {
      var isLoading = true.obs;
    }
  }

  //post data
  postorder({required Order order}) async {
    Order? existingOrder = await getOrder(order.orderId);

    if (existingOrder != null) {
      // existingOrder.totalGuest = totalGuest;
      for (var existingItem in existingOrder.order) {
        if (existingItem.fid == order.order[0].fid) {
          existingItem.quantity += 1;
        }
      }
      var data = jsonEncode(existingOrder.tojason());
      var url = Uri.parse(
          "https://657fe58b6ae0629a3f53d242.mockapi.io/orderCart/${order.orderId}");

      http.Response res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      log(res.body.toString());
    } else {
      var data = jsonEncode(order.tojason());
      var url = Uri.parse(Url.ordercartf);

      http.Response res = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: data,
      );

      log(res.body.toString());
    }
  }

//get by id
  Future<Order?> getOrder(String id) async {
    var url = Uri.parse(
        "https://657fe58b6ae0629a3f53d242.mockapi.io/orderCart/$id"); // Replace with your actual endpoint
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Order.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
