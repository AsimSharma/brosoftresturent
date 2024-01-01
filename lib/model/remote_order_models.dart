class History {
  int orderNo;
  int totalGuest;
  String tableName;
  String time;
  String scheduleFor;
  bool isCompleted;
  List<OrderItemsss> orders;
  List<OrderItemsss> addedOrders;
  String id;

  History({
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

  factory History.fromJson(Map<String, dynamic> json) {
    var data = json['orders'] as List;
    List<OrderItemsss> orderdata = data
        .map(
          (item) => OrderItemsss.fromJson(item),
        )
        .toList();
    return History(
        id: json['id'],
        orderNo: json['orderNo'],
        tableName: json['tableName'],
        time: json['time'],
        scheduleFor: json['scheduleFor'],
        isCompleted: json['isCompleted'],
        orders: orderdata,
        addedOrders: orderdata,
        totalGuest: json['totalGuest']);
  }

  Map<String, dynamic> tojason() => {
        "orderNo": orderNo,
        "tableName": tableName,
        "time": time,
        "scheduleFor": scheduleFor,
        "isCompleted": isCompleted,
        "orders": orders,
        "addedOrders": addedOrders,
        "totalGuest": totalGuest
      };
}

class OrderItemsss {
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

  OrderItemsss({
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

  factory OrderItemsss.fromJson(Map<String, dynamic> json) {
    var streetsFromJson = json['addons'];
    List<String> addonsList = List<String>.from(streetsFromJson);
    return OrderItemsss(
        fid: json['fid'],
        foodName: json['foodName'],
        tableName: json['tableName'],
        price: json['price'],
        quantity: json['quantity'],
        isCustomisable: json['isCustomisable'],
        isVeg: json['isVeg'],
        note: json['note'] ?? '',
        foodQuantity: json['foodQuantity'],
        spicyLevel: json['spicyLevel'] ?? "",
        addons: addonsList);
  }

  Map<String, dynamic> tojson() => {
        "fid": fid,
        "foodName": foodName,
        "tableName": tableName,
        "price": price,
        "quantity": quantity,
        "isCustomisable": isCustomisable,
        "isVeg": isVeg,
        "note": note,
        "foodQuantity": foodQuantity,
        "spicyLevel": spicyLevel
      };
}

enum FoodQuantity { EMPTY, HALF }

enum SpicyLevel { EMPTY, MEDIUM }
