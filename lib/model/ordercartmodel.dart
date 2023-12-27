import 'package:brosoftresturent/model/product_items.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class OrderCart {
  String orderId;
  String tableName;
  int totalGuest;
  int orderNo;
  int totalprices;
  List<ProductItem> productItems;

  OrderCart({
    String? orderId,
    required this.tableName,
    required this.totalGuest,
    required this.orderNo,
    required this.totalprices,
    required this.productItems,
  }) : orderId = orderId ?? uuid.v1();

  factory OrderCart.fromJson(Map<String, dynamic> json) {
    var data = json['productItems'] as List;
    List<ProductItem> dataa = data
        .map(
          (item) => ProductItem.fromJson(item),
        )
        .toList();
    return OrderCart(
      tableName: json['tableName'],
      totalGuest: json['totalGuest'],
      orderNo: json['orderNo'],
      totalprices: json['totalprices'],
      productItems: dataa,
    );
  }

  Map<String, dynamic> tojson() => {
        "tableName": tableName,
        "totalGuest": totalGuest,
        "orderNo": orderNo,
        "totalprices": totalprices,
        "productItems": productItems
      };
}

// class OrderProductItem {
//   String id;
//   String name;
//   int prices;
//   int quantity;

//   OrderProductItem(
//       {String? id,
//       required this.name,
//       required this.prices,
//       required this.quantity})
//       : id = id ?? uuid.v1();

//   factory OrderProductItem.fromJson(Map<String, dynamic> json) {
//     return OrderProductItem(
//         id: json['id'],
//         name: json['name'],
//         prices: json['prices'],
//         quantity: json['quntity']);
//   }

//   Map<String, dynamic> toJson() =>
//       {"id": id, "name": name, "prices": prices, "quantity": quantity};
// }
