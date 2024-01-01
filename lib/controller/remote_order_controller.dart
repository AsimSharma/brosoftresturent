import 'dart:convert';
import 'dart:developer';
import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/remote_order_models.dart';

class RemoteOrderCtrl extends GetxController {
  var historyList = <History>[].obs;

  var isLoading = false.obs;

  getHistoryOrders() async {
    isLoading = false.obs;
    try {
      isLoading = true.obs;
      var uri = Uri.parse(Url.orderHistoryFinal);
      http.Response response = await http.get(uri);
      List data = jsonDecode(response.body);
      historyList.addAll(data.map((item) => History.fromJson(item)).toList());
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
    historyList.refresh();
  }
}
