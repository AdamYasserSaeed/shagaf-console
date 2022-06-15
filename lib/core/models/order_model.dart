import 'package:shagf_console/core/models/item_model.dart';

class Order {
  String clientName;
  String? note;
  int clientPhone;
  int? clientSparePhone;
  String clientLocation;
  String clientLocationGoogleMap;
  List<Item> items;
  double total;
  String? status;
  int? id;

  Order(
      {required this.clientName,
      required this.id,
      required this.clientPhone,
      required this.clientLocation,
      required this.status,
      this.clientSparePhone,
      this.note,
      required this.clientLocationGoogleMap,
      required this.items,
      required this.total});
}
