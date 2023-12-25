// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/guest_userInfo.dart';
import 'package:brosoftresturent/model/product_items.dart';
import 'package:brosoftresturent/utils/url_constant.dart';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../model/tables_model.dart';

class TableController extends GetxController {
  var tables = <TableModel>[].obs;
  var noofseat = 0.obs;

  var isLooding = false.obs;

  var reserved = false.obs;

  increaseSeat(numberTotalguest) {
    if (numberTotalguest > noofseat) {
      noofseat++;
    } else {
      noofseat = 0.obs;
    }
  }

  dectasrseSeat() {
    if (noofseat <= 0) {
      noofseat = noofseat;
      log("cantnot add less than Zero");
    } else {
      noofseat--;
    }
    log(noofseat.toString());
  }

  changeReserved(int index1, int index2) {
    if (tables[index1].tableItem[index2].reserved = true) {
      reserved = false.obs;
    }
    {
      reserved = true.obs;
    }
  }

  getTables() async {
    isLooding = true.obs;

    try {
      var url = Uri.parse(Url.tableInfo);
      var response = await http.get(url);
      List data = jsonDecode(response.body);
      tables.addAll(data.map((items) => TableModel.fromJson(items)).toList());
      log(data.toString());
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
