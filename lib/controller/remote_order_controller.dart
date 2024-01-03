import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/remote_order_models.dart';

class RemoteOrderCtrl extends GetxController {
  var remoteOrderList = <RemoteOrderModel>[].obs;
  // final ordercontroller = Get.find<OrDerController>();

  var isLoading = false.obs;

  getHistoryOrders() async {
    isLoading = false.obs;
    try {
      isLoading = true.obs;
      var uri = Uri.parse(Url.orderHistoryFinal);
      http.Response response = await http.get(uri);
      List data = jsonDecode(response.body);
      remoteOrderList
          .addAll(data.map((item) => RemoteOrderModel.fromJson(item)).toList());
      log(data.toString());
      isLoading = false.obs;
    } catch (err) {
      log(err.toString());
    }
  }

  cancelById(String id) async {
    log("this is delete by id  $id");

    isLoading = false.obs;
    try {
      isLoading = true.obs;
      var uri = Uri.parse('${Url.orderHistoryFinal}/$id');
      http.Response response = await http.delete(uri);
      log(response.body);
    } catch (err) {
      log(err.toString());
    } finally {
      isLoading = false.obs;
    }

    update();
    getHistoryOrders();
    remoteOrderList.refresh();
  }

//post
  postTORemoteCart(int orderNo, int totalGuest, String tableName, String time,
      String scheduleFor, List<Order> ordersItems) async {
    log("I am from remote postToCart");
    RemoteOrderModel newRemoteOrder = RemoteOrderModel(
      id: "1",
      orderNo: orderNo,
      totalGuest: totalGuest,
      tableName: tableName,
      time: DateTime.now(),
      scheduleFor: DateTime.now(),
      isCompleted: false,
      orders: ordersItems,
      addedOrders: [],
    );
    try {
      var uri = Uri.parse(Url.remoteOrderPost);
      var data = jsonEncode(newRemoteOrder.toJson());
      log("Data : $data");

      http.Response res = await http.post(
        uri,
        body: data,
      );
      log(data.toString());
      log(res.body.toString());
    } catch (err) {
      log(err.toString());
    }

    update();
  }
}
