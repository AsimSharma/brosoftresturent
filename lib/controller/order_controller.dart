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
  }) async {
    // Order? existingOrder = await getOrder(orderNo);
    // if (existingOrder != null) {
    //   // Order already exists, update the quantity
    //   existingOrder.totalGuest = totalGuest;

    //   // Update quantity of existing items
    //   for (var existingItem in existingOrder.order) {
    //     if (existingItem.fname == "ds") {
    //       // Assuming "ds" is the unique identifier for the existing item
    //       existingItem.quantity += 1; // Update the quantity as needed
    //     }
    //     // Add more conditions for other existing items if needed
    //   }

    //   var data = jsonEncode(existingOrder.tojason());
    //   var url = Uri.parse(Url.ordercartf);

    //   http.Response res = await http.put(
    //     url, // Assuming your backend supports updating via HTTP PUT
    //     headers: {'Content-Type': 'application/json'},
    //     body: data,
    //   );

    //   log(res.body.toString());
    // }

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

  // Function to get an order by orderNo
  Future<Order?> getOrder(int orderNo) async {
    var url = Uri.parse(${Url.ordercart}/{id}); // Replace with your actual endpoint
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the response and return the Order if found
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Order.fromJson(jsonResponse);
    } else {
      // Order not found or error occurred
      return null;
    }
  }
}
