import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Products {
  String productName;
  List<ProductItem> productItem;

  Products({
    required this.productName,
    required this.productItem,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    var productItem = json['productItem'] as List;
    List<ProductItem> dproductItem =
        productItem.map((items) => ProductItem.fromJson(items)).toList();
    return Products(
      productName: json['productName'],
      productItem: dproductItem,
    );
  }
}

class ProductItem {
  String id;
  String name;
  int prices;
  int quantity;
  bool veg;
  bool customize;
  bool isAdded;

  ProductItem(
      {String? id,
      required this.name,
      required this.prices,
      required this.quantity,
      required this.veg,
      required this.customize,
      required this.isAdded})
      : id = id ?? uuid.v1();

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['name'],
      prices: json['prices'],
      quantity: json['quantity'],
      veg: json['veg'],
      customize: json['customize'],
      isAdded: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "prices": prices,
        "quantity": quantity,
        "veg": veg,
        "customize": customize,
        "isAdded": isAdded
      };
}
