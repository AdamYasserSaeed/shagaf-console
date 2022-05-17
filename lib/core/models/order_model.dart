import 'package:shagf_console/core/models/item_model.dart';

class Order {
  final String clientName;
  final int clientPhone;
  final int? clientSparePhone;
  final String clientLocation;
  final String clientLocationGoogleMap;
  final List items;
  final double total;

  Order(
      {required this.clientName,
      required this.clientPhone,
      required this.clientLocation,
      this.clientSparePhone,
      required this.clientLocationGoogleMap,
      required this.items,
      required this.total});
}
