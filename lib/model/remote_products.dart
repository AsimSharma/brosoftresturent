class Foods {
  String foodCategories;
  String id;
  List<FoodItems> foodItems;

  Foods({
    required this.id,
    required this.foodCategories,
    required this.foodItems,
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    var productItem = json['foodItems'] as List;
    List<FoodItems> dproductItem =
        productItem.map((items) => FoodItems.fromJson(items)).toList();
    return Foods(
      id: json['id'],
      foodCategories: json['foodCategories'],
      foodItems: dproductItem,
    );
  }
}

class FoodItems {
  int fid;
  String fname;
  int prices;
  int quantity;
  bool isCustomize;
  bool isVeg;
  bool isAdded;
  int totalQuantity;

  FoodItems({
    required this.fid,
    required this.fname,
    required this.prices,
    required this.quantity,
    required this.isCustomize,
    required this.isVeg,
    required this.isAdded,
    required this.totalQuantity,
  });

  factory FoodItems.fromJson(Map<String, dynamic> json) {
    return FoodItems(
        fid: json['fid'],
        fname: json['fname'],
        prices: json['prices'],
        quantity: json['quantity'],
        isVeg: json['isVeg'],
        isCustomize: json['isCustomize'],
        isAdded: false,
        totalQuantity: 0);
  }

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "fname": fname,
        "prices": prices,
        "quantity": quantity,
        "isVeg": isVeg,
        "isCustomize": isCustomize,
        "isAdded": isAdded,
        "totalQuantity": totalQuantity
      };
}
