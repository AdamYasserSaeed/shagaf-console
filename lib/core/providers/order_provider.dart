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
    try {
      firestore.snapshots().listen(
        (event) {
          for (var item in event.docChanges) {
            orders.add(
              Order(
                id: int.parse(item.doc.id),
                status: item.doc["status"].toString(),
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
                items: [
                  for (var item in item.doc["order"])
                    Item(
                      name: item["name"],
                      price: double.parse(item["price"].toString()),
                      id: item["id"].toString(),
                      category: item["category"],
                      count: int.parse(item["quantity"].toString()),
                      total: double.parse(item["total"].toString()),
                    ),
                ],
                total: double.parse(item.doc["total"].toString()),
              ),
            );
            print("done!");
            notifyListeners();
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void changeStatus(taxNum, status) async {
    await FirebaseFirestore.instance.collection("orders").doc(taxNum.toString()).update(
      {"status": status.toString()},
    );
    notifyListeners();
  }
}
