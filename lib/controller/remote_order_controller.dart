import 'dart:developer';
import 'package:get/get.dart';
import '../model/remote_order_models.dart';

class RemoteOrderCtrl extends GetxController {
  var remoteOrderList = <RemoteOrderModel>[].obs;
  // final ordercontroller = Get.find<OrDerController>();
  bool isLoading2 = false;
  var isLoading = false.obs;

  // getHistoryOrders() async {
  //   isLoading = false.obs;
  //   try {
  //     isLoading = true.obs;
  //     var uri = Uri.parse(Url.orderHistoryFinal);
  //     http.Response response = await http.get(uri);
  //     List data = jsonDecode(response.body);
  //     remoteOrderList
  //         .addAll(data.map((item) => RemoteOrderModel.fromJson(item)).toList());
  //     log(data.toString());
  //     isLoading = false.obs;
  //   } catch (err) {
  //     log(err.toString());
  //   }
  // }

  // cancelByIdRemote(String id) async {
  //   log("this is delete by id  $id");

  //   isLoading = false.obs;
  //   try {
  //     isLoading = true.obs;
  //     var uri = Uri.parse('${Url.orderHistoryFinal}/$id');
  //     http.Response response = await http.delete(uri);
  //     log(response.body);
  //   } catch (err) {
  //     log(err.toString());
  //   } finally {
  //     isLoading = false.obs;
  //   }

  //   update();
  //   getHistoryOrders();
  //   remoteOrderList.refresh();
  // }

//post
  // postTORemoteCart(int orderNo, int totalGuest, String tableName, String time,
  //     String scheduleFor, List<Order> ordersItems) async {
  //   log("I am from remote postToCart");
  //   RemoteOrderModel newRemoteOrder = RemoteOrderModel(
  //     id: "1",
  //     orderNo: orderNo,
  //     totalGuest: totalGuest,
  //     tableName: tableName,
  //     time: DateTime.now(),
  //     scheduleFor: DateTime.now(),
  //     isCompleted: false,
  //     orders: ordersItems,
  //     addedOrders: [],
  //   );
  //   try {
  //     var uri = Uri.parse(Url.remoteOrderPost);
  //     var data = jsonEncode(newRemoteOrder.toJson());
  //     log("Data : $data");

  //     http.Response res = await http.post(
  //       uri,
  //       body: data,
  //     );
  //     log(data.toString());
  //     log(res.body.toString());
  //   } catch (err) {
  //     log(err.toString());
  //   }

  //   update();
  // }

  cancelById(String id) {
    bool hasItems = false;
    for (RemoteOrderModel item in remoteOrderList) {
      if (item.id == id) {
        hasItems = true;
      }
    }

    if (hasItems) {
      isLoading2 = true;
      log(id);
      remoteOrderList.removeWhere((item) => item.id == id);
      isLoading2 = false;
    }

    update();
  }

  addOrders(RemoteOrderModel order) {
    // for (int i = 0; i < order.length; i++) {
    //   remoteOrderList.add(order[i]);
    //   log("Orders  added  Sucessfully");
    // }
    remoteOrderList.add(order);
    log("Orders  added  Sucessfully");
  }

//update the orders add orders
  updateAddOrders(String id, List<Order> addedOrders) {
    // int index1 =
    //     remoteOrderList.indexWhere((p0) => p0.id == remoteorderItem.id);
    // remoteOrderList[index1].addedOrders.add();

    for (int i = 0; i < remoteOrderList.length; i++) {
      if (remoteOrderList[i].id == id) {
        for (int j = 0; j < addedOrders.length; j++) {
          remoteOrderList[i].addedOrders.add(addedOrders[j]);
          log("Orders  update  Sucessfully");
        }
      }
    }
    update();
  }
}
