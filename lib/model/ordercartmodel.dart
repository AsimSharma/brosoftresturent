class OrderCart {
  String tableName;
  int guest;
  int orderNo;
  int totalprices;
  int totalItem;
  List<PrductItem> productItems;

  OrderCart({
    required this.tableName,
    required this.guest,
    required this.orderNo,
    required this.totalprices,
    required this.totalItem,
    required this.productItems,
  });

  Map<String, dynamic> tojson() => {
        "tableName": tableName,
        "guest": guest,
        "orderNo": orderNo,
        "totalprices": totalprices,
        "totalItem": totalItem,
        "productItems": productItems
      };
}

class PrductItem {
  String itemName;
  int rs;
  bool customize;
  bool veg;

  PrductItem({
    required this.itemName,
    required this.rs,
    required this.customize,
    required this.veg,
  });

  Map<String, dynamic> toJson() =>
      {"itemName": itemName, "rs": rs, "customer": customize, "veg": veg};
}
