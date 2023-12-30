import 'dart:convert';
import 'dart:developer';
import 'package:brosoftresturent/model/order_models.dart';
import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';

import "package:http/http.dart" as http;

class OrderCartCtrl extends GetxController {
  //post data

  postorder({
    required int orderNo,
    required String tableName,
    required String time,
    required String sheduleFor,
    required bool isComplete,
    required int totalGuest,
    required String fid,
  }) async {
    Order? existingOrder = await getOrder("3");
    if (existingOrder != null) {
      existingOrder.totalGuest = totalGuest;
      for (var existingItem in existingOrder.order) {
        if (existingItem.fid == fid) {
          existingItem.quantity += 1;
        }
      }
      var data = jsonEncode(existingOrder.tojason());
      var url =
          Uri.parse("https://657fe58b6ae0629a3f53d242.mockapi.io/orderCart/4");

      http.Response res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      log(res.body.toString());
    }

    Order newOrder = Order(
        orderNo: orderNo,
        tableName: tableName,
        time: time,
        sheduleFor: sheduleFor,
        isComplete: isComplete,
        order: [
          // OrderItem(
          //     fname: "ds",
          //     ftableName: "aSAS",
          //     fprices: 150,
          //     quantity: 2,
          //     fcustomize: true,
          //     fveg: true,
          //     note: "",
          //     foodquantity: 5,
          //     spicyLevel: "mid")
        ],
        addOrder: [],
        totalGuest: totalGuest);
    var data = jsonEncode(newOrder.tojason());
    var url = Uri.parse(Url.ordercartf);

    http.Response res = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: data,
    );

    log(res.body.toString());
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
