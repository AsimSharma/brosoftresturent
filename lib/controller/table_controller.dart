// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/guest_userinfo.dart';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:brosoftresturent/view/widgets/toast_message.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../model/tables_model.dart';

class TableController extends GetxController {
  var tables = <TableModel>[].obs;
  var noofseat = 0.obs;
  var isLooding = false.obs;
  // var reserved = false.obs;

  increaseSeat(BuildContext context, tableIndex1, int tableIndex2) {
    var currentTable = tables[tableIndex1].tableItem[tableIndex2];
    if (noofseat < currentTable.seat) {
      noofseat++;
    } else {
      showToast(context, "yo cant add more seats");
    }
  }

  decreaseSeat(
    BuildContext context,
  ) {
    if (noofseat > 0) {
      noofseat--;
    } else {
      noofseat = 0.obs;
      showToast(context, "numner cannot be less than Zero");
    }
  }

  // changeReserved(TableModel tableModels,TableItem,) {
  //   for (TableItem item in tables[index].tableItem) {
  //     log(item.toString());
  //     item.reserved = !item.reserved;
  //     log(item.reserved.toString());
  //     tables.refresh();
  //     update();
  //   }
  // }

  getTables() async {
    isLooding = false.obs;

    try {
      isLooding = true.obs;
      var url = Uri.parse(Url.tableinfo);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      tables.addAll(data.map((items) => TableModel.fromJson(items)).toList());
      log(data.toString());
    } catch (err) {
      log(err.toString());
    } finally {
      isLooding = false.obs;
    }
  }

//postInfo
  postGuestInfo({required GuestModel guestModel}) async {
    isLooding = true.obs;
    try {
      var url = Uri.parse("${Url.resturentApiEndPoint}/guestInfo");
      var value = jsonEncode(guestModel.tojson());
      var response = await http.post(url, body: value);
      log(response.body);
    } finally {
      isLooding = false.obs;
    }
  }
}
