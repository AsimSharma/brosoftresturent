//this is order cart models
//final

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Order {
  String? id;
  int orderNo;
  String tableName;
  String time;
  String sheduleFor;
  bool isComplete;
  List<OrderItem> order;
  List<dynamic> addOrder;

  int totalGuest;

  Order({
    required this.orderNo,
    required this.tableName,
    required this.time,
    required this.sheduleFor,
    required this.isComplete,
    required this.order,
    required this.addOrder,
    required this.totalGuest,
    String? id,
  }) : id = id ?? uuid.v1();

  factory Order.fromJson(Map<String, dynamic> json) {
    var data = json['order'] as List;
    List<OrderItem> orderdata = data
        .map(
          (item) => OrderItem.fromJson(item),
        )
        .toList();
    return Order(
        orderNo: json['orderNo'],
        tableName: json['tableName'],
        time: json['time'],
        sheduleFor: json['sheduleFor'],
        isComplete: json['isComplete'],
        order: orderdata,
        addOrder: json['addOrder'],
        id: json['id'] ?? "",
        totalGuest: json['totalGuest']);
  }

  Map<String, dynamic> tojason() => {
        "orderNo": orderNo,
        "tableName": tableName,
        "time": time,
        "sheduleFor": sheduleFor,
        "isComplete": isComplete,
        "order": order,
        "addOrder": addOrder,
        "id": id,
        "totalGuest": totalGuest
      };
}

class OrderItem {
  String fid;
  String fname;
  String ftableName;
  int fprices;
  int quantity;
  bool fcustomize;
  bool fveg;
  String note;
  int foodquantity;
  String spicyLevel;

  OrderItem({
    String? fid,
    required this.fname,
    required this.ftableName,
    required this.fprices,
    required this.quantity,
    required this.fcustomize,
    required this.fveg,
    required this.note,
    required this.foodquantity,
    required this.spicyLevel,
  }) : fid = fid ?? uuid.v1();

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        fid: json['fid'],
        fname: json['fname'],
        ftableName: json['ftableName'],
        fprices: json['fprices'],
        quantity: json['quantity'],
        fcustomize: json['fcustomize'],
        fveg: json['fveg'],
        note: json['note'] ?? '',
        foodquantity: json['foodquantity'],
        spicyLevel: json['spicyLevel'] ?? "");
  }

  Map<String, dynamic> tojson() => {
        "fid": fid,
        "fname": fname,
        "ftableName": ftableName,
        "fprices": fprices,
        "quantity": quantity,
        "fcustomize": fcustomize,
        "fveg": fveg,
        "note": note,
        "foodquantity": foodquantity,
        "spicyLevel": spicyLevel
      };
}
