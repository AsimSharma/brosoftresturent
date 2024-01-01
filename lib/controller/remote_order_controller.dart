import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/remote_order_models.dart';
import 'order_cart_controller.dart';

class RemoteOrderCtrl extends GetxController {
  var remoteOrderList = <RemoteOrderModel>[].obs;
  final ordercontroller = Get.find<OrDerController>();

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
      String scheduleFor) async {
    RemoteOrderModel newRemoteOrder = RemoteOrderModel(
      orderNo: orderNo,
      totalGuest: totalGuest,
      tableName: tableName,
      time: time,
      scheduleFor: scheduleFor,
      isCompleted: false,
      orders: [],
      addedOrders: [],
    );
    try {
      var uri = Uri.parse(Url.orderHistoryFinal);
      var data = jsonEncode(newRemoteOrder.tojason());

      http.Response res = await http.post(
        uri,
        body: data,
      );
      log(res.body.toString());
    } catch (err) {
      log(err.toString());
    }
  }
}
