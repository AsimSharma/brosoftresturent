// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';
import 'package:brosoftresturent/model/guest_info_model.dart';
import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../model/tables_model.dart';

class TableController extends GetxController {
  var tables = <TableModel>[].obs;
  // var noofseat = 0.obs;
  var isLooding = false.obs;

  // var reserved = false.obs;
  // increaseSeat(BuildContext context, tableIndex1, int tableIndex2) {
  //   var currentTable = tables[tableIndex1].tableItem[tableIndex2];
  //   if (noofseat < currentTable.seat) {
  //     noofseat++;
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Can't  add more guest",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  // decreaseSeat(
  //   BuildContext context,
  // ) {
  //   if (noofseat > 0) {
  //     noofseat--;
  //   } else {
  //     noofseat = 0.obs;
  //     Fluttertoast.showToast(
  //         msg: "Guest can't be less than Zero",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  increaseSeat(TableModel tableModel, TableItem tableItem, int totalguest) {
    // int index1 = tables.indexWhere((p0) => p0.id == tableModel.id);
    // int index2 = tables[index1].tableItem.indexWhere(
    //       (p1) => p1.tid == tableItem.tid,
    //     );

    // if (tables[index1].tableItem[index2].seat >
    //     tables[index1].tableItem[index2].totalguest!) {
    //   tables[index1].tableItem[index2].totalguest! + 10;
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Guest can't be less than Zero",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }

    for (int i = 0; i < tables.length; i++) {
      for (int j = 0; j < tables[i].tableItem.length; j++) {
        if (tableItem.tid == tables[i].tableItem[j].tid) {
          tables[i].tableItem[j].totalguest = totalguest;
          update();
          log(tables[i].tableItem[j].totalguest.toString());
        }
      }
    }

    update();
    tables.refresh();
  }

  changeReserved(TableModel tableModels, TableItem tableItem) {
    var index1 = tables.indexWhere((p0) => p0.id == tableModels.id);
    var index2 =
        tables[index1].tableItem.indexWhere((p1) => p1.tid == tableItem.tid);
    if (tables[index1].tableItem[index2].reserved == false) {
      tables[index1].tableItem[index2].reserved = true;
      tables.refresh();
      update();
    } else {
      tables[index1].tableItem[index2].reserved = false;
      tables.refresh();
      update();
    }
    tables.refresh();
    update();
  }

  getTables() async {
    isLooding = false.obs;

    try {
      isLooding.value = true;
      var url = Uri.parse(Url.tableinfo);
      var response = await http.get(url);
      List data = jsonDecode(response.body);

      tables.value = <TableModel>[].obs;

      tables
          .assignAll(data.map((items) => TableModel.fromJson(items)).toList());
      isLooding.value = true;
    } catch (err) {
      log(err.toString());
    }
    update();
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

  //todo make the current guest in tables
}
