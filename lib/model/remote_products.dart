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
  int customizeQuantity;
  int customizePrices;

  FoodItems({
    required this.fid,
    required this.fname,
    required this.prices,
    required this.quantity,
    required this.isCustomize,
    required this.isVeg,
    required this.isAdded,
    required this.customizeQuantity,
    required this.customizePrices,
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
      customizePrices: json['prices'],
      customizeQuantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "fname": fname,
        "prices": prices,
        "quantity": quantity,
        "isVeg": isVeg,
        "isCustomize": isCustomize,
        "isAdded": isAdded,
      };
}
