// To parse this JSON data, do
//
//     final remoteOrderModel = remoteOrderModelFromJson(jsonString);

import 'dart:convert';

List<RemoteOrderModel> remoteOrderModelFromJson(String str) =>
    List<RemoteOrderModel>.from(
        json.decode(str).map((x) => RemoteOrderModel.fromJson(x)));

String remoteOrderModelToJson(List<RemoteOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RemoteOrderModel {
  int orderNo;
  int totalGuest;
  String tableName;
  DateTime time;
  DateTime scheduleFor;
  bool isCompleted;
  List<Order> orders;
  List<Order> addedOrders;
  String id;

  RemoteOrderModel({
    required this.orderNo,
    required this.totalGuest,
    required this.tableName,
    required this.time,
    required this.scheduleFor,
    required this.isCompleted,
    required this.orders,
    required this.addedOrders,
    required this.id,
  });

  factory RemoteOrderModel.fromJson(Map<String, dynamic> json) =>
      RemoteOrderModel(
        orderNo: json["orderNo"],
        totalGuest: json["totalGuest"],
        tableName: json["tableName"],
        time: DateTime.parse(json["time"]),
        scheduleFor: DateTime.parse(json["scheduleFor"]),
        isCompleted: json["isCompleted"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        addedOrders:
            List<Order>.from(json["addedOrders"].map((x) => Order.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "totalGuest": totalGuest,
        "tableName": tableName,
        "time": time.toIso8601String(),
        "scheduleFor": scheduleFor.toIso8601String(),
        "isCompleted": isCompleted,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "addedOrders": List<dynamic>.from(addedOrders.map((x) => x.toJson())),
        "id": id,
      };
}

class Order {
  int fid;
  String foodName;
  String tableName;
  int quantity;
  int price;
  String note;
  String foodQuantity;
  String spicyLevel;
  List<String> addons;
  bool isCustomisable;
  bool isVeg;

  Order({
    required this.fid,
    required this.foodName,
    required this.tableName,
    required this.quantity,
    required this.price,
    required this.note,
    required this.foodQuantity,
    required this.spicyLevel,
    required this.addons,
    required this.isCustomisable,
    required this.isVeg,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        fid: json["fid"],
        foodName: json["foodName"],
        tableName: json["tableName"],
        quantity: json["quantity"],
        price: json["price"],
        note: json["note"],
        foodQuantity: json["foodQuantity"],
        spicyLevel: json["spicyLevel"],
        addons: List<String>.from(json["addons"].map((x) => x)),
        isCustomisable: json["isCustomisable"],
        isVeg: json["isVeg"],
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "foodName": foodName,
        "tableName": tableName,
        "quantity": quantity,
        "price": price,
        "note": note,
        "foodQuantity": foodQuantity,
        "spicyLevel": spicyLevel,
        "addons": List<dynamic>.from(addons.map((x) => x)),
        "isCustomisable": isCustomisable,
        "isVeg": isVeg,
      };
}
