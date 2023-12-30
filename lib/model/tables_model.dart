import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TableModel {
  String tabletype;
  List<TableItem> tableItem;
  String id;

  TableModel({
    String? id,
    required this.tabletype,
    required this.tableItem,
  }) : id = id ?? uuid.v1();

  factory TableModel.fromJson(Map<String, dynamic> json) {
    var dataItem = json['tableItem'] as List;
    List<TableItem> maptableitem =
        dataItem.map((items) => TableItem.fromJson(items)).toList();

    return TableModel(
        tabletype: json['tabletype'], tableItem: maptableitem, id: json['id']);
  }

  Map<String, dynamic> tojson() =>
      {"tabletype": tabletype, "tableItem": tableItem, "id": id};
}

class TableItem {
  String tableName;
  bool reserved;
  int seat;
  String tid;

  TableItem({
    String? tid,
    required this.tableName,
    required this.reserved,
    required this.seat,
  }) : tid = tid ?? uuid.v1();

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
        tableName: json['tableName'],
        reserved: json['reserved'],
        seat: json['seat'],
        tid: json['tid']);
  }

  Map<String, dynamic> tojson() => {
        "tableName": tableName,
        "reserved": reserved,
        "seat": seat,
        "tid": tid,
      };
}
