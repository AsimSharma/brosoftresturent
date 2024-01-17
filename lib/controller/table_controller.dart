// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../model/tables_model.dart';

class TableController extends GetxController {
  var tables = <TableModel>[].obs;

  var isLooding = false.obs;

  increaseSeat(TableModel tableModel, TableItem tableItem) {
    for (int i = 0; i < tables.length; i++) {
      for (int j = 0; j < tables[i].tableItem.length; j++) {
        if (tableItem.tid == tables[i].tableItem[j].tid) {
          if (tables[i].tableItem[j].totalguest! < tableItem.seat) {
            tables[i].tableItem[j].totalguest =
                tables[i].tableItem[j].totalguest! + 1;
            update();
            tables.refresh();
          } else {
            Fluttertoast.showToast(
                msg: "Can't  add more guest",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      }
    }

    update();
    tables.refresh();
  }

  decreaseSeat(TableModel tableModel, TableItem tableItem) {
    for (int i = 0; i < tables.length; i++) {
      for (int j = 0; j < tables[i].tableItem.length; j++) {
        if (tableItem.tid == tables[i].tableItem[j].tid) {
          if (tables[i].tableItem[j].totalguest! > 0) {
            tables[i].tableItem[j].totalguest =
                tables[i].tableItem[j].totalguest! - 1;
          } else {
            Fluttertoast.showToast(
                msg: "Guest can't be less than Zero",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      }
    }

    update();
    tables.refresh();
  }

  int findAddedGuest(String id) {
    int totalAddedGuest = 0;
    for (int i = 0; i < tables.length; i++) {
      for (int j = 0; j < tables[i].tableItem.length; j++) {
        if (tables[i].tableItem[j].tid == id) {
          totalAddedGuest = tables[i].tableItem[j].totalguest!;
          log("the added total quest $totalAddedGuest");
          update();
        }
      }
    }
    return totalAddedGuest;
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
      await Future.delayed(const Duration(microseconds: 3000));
      isLooding = true.obs;

      var url = Uri.parse(Url.tableinfo);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      tables.value = <TableModel>[].obs;
      tables
          .assignAll(data.map((items) => TableModel.fromJson(items)).toList());
    } catch (err) {
      log(err.toString());
    } finally {
      isLooding = false.obs;
    }
    update();
  }
}
