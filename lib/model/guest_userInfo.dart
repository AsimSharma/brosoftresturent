class GuestModel {
  final int noOfGuest;
  final num number;
  final num customerNumber;
  final String id;
  final String name;

  GuestModel(
      {required this.name,
      required this.noOfGuest,
      required this.number,
      required this.customerNumber,
      required this.id});

  Map<String, dynamic> tojson() => {
        'noOfGuest': noOfGuest,
        'number': number,
        'customerNumber': customerNumber,
        "name": name,
        'id': id,
      };
}
