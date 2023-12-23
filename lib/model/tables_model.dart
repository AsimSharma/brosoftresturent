class TableModel {
  String tabletype;
  List<TableItem> tableItem;

  TableModel({
    required this.tabletype,
    required this.tableItem,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    var dataItem = json['tableItem'] as List;
    List<TableItem> maptableitem =
        dataItem.map((items) => TableItem.fromJson(items)).toList();

    return TableModel(tabletype: json['tabletype'], tableItem: maptableitem);
  }
}

class TableItem {
  String tableName;
  bool reserved;
  int seat;

  TableItem({
    required this.tableName,
    required this.reserved,
    required this.seat,
  });

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
        tableName: json['tableName'],
        reserved: json['reserved'],
        seat: json['seat']);
  }
}
