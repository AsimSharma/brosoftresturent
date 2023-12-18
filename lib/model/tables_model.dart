class TableModels {
  String tableName;
  bool reserved;
  num number;
  String id;

  TableModels(
      {required this.tableName,
      required this.reserved,
      required this.number,
      required this.id});

  factory TableModels.fromjson(Map<String, dynamic> json) => TableModels(
      tableName: json['tableName'],
      reserved: json['reserved'],
      number: json['number'],
      id: json['id']);
}
