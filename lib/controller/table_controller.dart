// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import 'package:brosoftresturent/model/guest_userInfo.dart';
import 'package:brosoftresturent/utils/url_constant.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../model/tables_model.dart';

class TableController extends GetxController {
  var tables = <TableModel>[].obs;

  getTables() async {
    var url = Uri.parse(Url.tableInfo);
    var response = await http.get(url);
    List data = jsonDecode(response.body);
    tables.addAll(data.map((items) => TableModel.fromJson(items)).toList());
    log(data.toString());
  }

//postInfo
  postGuestInfo({required GuestModel guestModel}) async {
    log("postGuestMethodsCall");
    var url = Uri.parse("${Url.resturentApiEndPoint}/guestInfo");
    var value = jsonEncode(guestModel.tojson());
    var response = await http.post(url, body: value);
    log(response.body);
  }
}
