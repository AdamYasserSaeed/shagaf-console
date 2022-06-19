import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shagf_console/core/models/item_model.dart';

class Order {
  String? note;
  Timestamp? time;
  List<Item> items;
  double total;
  String? id;
  int tableNum;
  // String clientName;
  // String? note;
  // int clientPhone;
  // int? clientSparePhone;
  // String clientLocation;
  // String clientLocationGoogleMap;
  // List<Item> items;
  // double total;
  String? status;
  // int? id;

  Order({
    required this.id,
    this.note,
    this.time,
    this.status,
    required this.items,
    required this.total,
    required this.tableNum,
  });
}
