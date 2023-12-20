// class Products {
//   String productName;
//   List<ProductItem> productItem;

//   Products({
//     required this.productName,
//     required this.productItem,
//   });
//   factory Products.fromJson(Map<String, dynamic> json) {
//     var productItem = json['productItem'] as List;
//     List<ProductItem> dproductItem =
//         productItem.map((items) => ProductItem.fromJson(items)).toList();
//     return Products(
//         productName: json['productName'], productItem: dproductItem);
//   }
// }

// //////
// class ProductItem {
//   String itemName;
//   int rs;
//   bool customize;
//   bool veg;

//   ProductItem({
//     required this.itemName,
//     required this.rs,
//     required this.customize,
//     required this.veg,
//   });

//   factory ProductItem.fromJson(Map<String, dynamic> json) {
//     return ProductItem(
//       itemName: json['itemName'],
//       rs: json['rs'],
//       customize: json['customize'],
//       veg: json['veg'],
//     );
//   }
// }

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
  String itemName;
  int rs;
  bool customize;
  bool veg;

  ProductItem({
    required this.itemName,
    required this.rs,
    required this.customize,
    required this.veg,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      itemName: json['itemName'],
      rs: json['rs'],
      customize: json['customize'],
      veg: json['veg'],
    );
  }
}
