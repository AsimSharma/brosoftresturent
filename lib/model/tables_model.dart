class TableModels {
  String tableName;
  bool reserved;
  num noOfGuest;
  String id;

  TableModels(
      {required this.tableName,
      required this.reserved,
      required this.noOfGuest,
      required this.id});

  factory TableModels.fromjson(Map<String, dynamic> json) => TableModels(
      tableName: json['tableName'],
      reserved: json['reserved'],
      noOfGuest: json['noOfGuest'],
      id: json['id']);
}
