class Cruddemo {
  String productName;
  List<CruddemoItem> productItem;

  Cruddemo({
    required this.productName,
    required this.productItem,
  });

  factory Cruddemo.fromJson(Map<String, dynamic> json) {
    var productItem = json['productItem'] as List;
    List<CruddemoItem> dproductItem =
        productItem.map((items) => CruddemoItem.fromJson(items)).toList();
    return Cruddemo(
      productName: json['productName'],
      productItem: dproductItem,
    );
  }
}

class CruddemoItem {
  String itemName;
  int rs;
  bool customize;
  bool veg;

  CruddemoItem({
    required this.itemName,
    required this.rs,
    required this.customize,
    required this.veg,
  });

  factory CruddemoItem.fromJson(Map<String, dynamic> json) {
    return CruddemoItem(
      itemName: json['itemName'],
      rs: json['rs'],
      customize: json['customize'],
      veg: json['veg'],
    );
  }
}
