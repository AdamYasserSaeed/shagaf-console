import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shagf_console/core/models/item_model.dart';
import 'package:shagf_console/core/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> orders = [];

  void getRealTimeOrders() async {
    final firestore = FirebaseFirestore.instance.collection("orders");

    orders.clear();

    firestore.snapshots().listen(
      (event) {
        for (var item in event.docChanges) {
          orders.add(
            Order(
              clientName: item.doc["clientName"].toString(),
              clientPhone: int.parse(item.doc["clientPhone"].toString()),
              clientLocation: "area name : " +
                  item.doc["clientAreaName"].toString() +
                  "/ Street name :" +
                  item.doc["clientStName"].toString() +
                  "/ building number : " +
                  item.doc["clientBuildingNum"].toString() +
                  "/ floor number : " +
                  item.doc["clientFloorNum"].toString(),
              clientSparePhone: int.parse(item.doc["clientSecPhone"].toString()),
              clientLocationGoogleMap: item.doc["googleMapsUrl"].toString(),
              items: item.doc["order"].map((item) {
                Item(
                  name: item["name"],
                  price: double.parse(item["price"].toString()),
                  id: item["id"].toString(),
                  category: item["category"],
                  count: int.parse(item["quantity"].toString()),
                  total: double.parse(item["total"].toString()),
                );
              }).toList(),
              total: double.parse(item.doc["total"].toString()),
            ),
          );
          print("done!");
          notifyListeners();
        }
      },
    );
  }
}
