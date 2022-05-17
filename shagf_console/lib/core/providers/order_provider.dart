import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shagf_console/core/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> orders = [];
  void getRealTimeOrders() async {
    final firestore = await FirebaseFirestore.instance.collection("orders").get();

    for (var order in firestore.docs) {
      print(order['clientName']);
    }
  }
}
