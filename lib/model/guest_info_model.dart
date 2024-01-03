class GuestModel {
  final num number;
  final num customerNumber;
  final String id;
  final String name;

  GuestModel(
      {required this.name,
      required this.number,
      required this.customerNumber,
      required this.id});

  Map<String, dynamic> tojson() => {
        'number': number,
        'customerNumber': customerNumber,
        "name": name,
        'id': id,
      };
}
