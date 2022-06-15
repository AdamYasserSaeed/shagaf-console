// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shagf_console/core/models/delivery_model.dart';
import 'package:shagf_console/core/models/item_model.dart';
import 'package:shagf_console/core/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> orders = [];
  final List<Delivery> delivery = [];

  void getRealTimeOrders() async {
    final firestore = FirebaseFirestore.instance.collection("orders");

    orders.clear();
    try {
      firestore.orderBy('time', descending: false).snapshots().listen(
        (event) {
          for (var order in event.docChanges) {
            orders.add(
              Order(
                id: int.parse(order.doc.id),
                status: order.doc["status"].toString(),
                clientName: order.doc["clientName"].toString(),
                clientPhone: int.parse(order.doc["clientPhone"].toString()),
                clientLocation: "\n area name : " +
                    order.doc["clientAreaName"].toString() +
                    "\n Street name :" +
                    order.doc["clientStName"].toString() +
                    "\n building number : " +
                    order.doc["clientBuildingNum"].toString() +
                    "\n floor number : " +
                    order.doc["clientFloorNum"].toString(),
                clientSparePhone: int.parse(order.doc["clientSecPhone"].toString()),
                clientLocationGoogleMap: order.doc["googleMapsUrl"].toString(),
                items: [
                  for (var item in order.doc["order"])
                    Item(
                      name: item["name"],
                      price: double.parse(item["price"].toString()),
                      id: item["id"].toString(),
                      category: item["category"],
                      count: int.parse(item["quantity"].toString()),
                      total: double.parse(item["total"].toString()),
                    ),
                ],
                total: double.parse(order.doc["total"].toString()),
              ),
            );
            notifyListeners();
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void getDeliveryMen() async {
    final firestore = await FirebaseFirestore.instance.collection("delivery").get();

    delivery.clear();
    try {
      for (var deliveryMan in firestore.docs) {
        delivery.add(
          Delivery(
            name: deliveryMan["name"],
            phone: deliveryMan["phone"],
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void searchOrder(id) {
    orders.where((element) => element.id == id);
  }

  void changeStatus(taxNum, status) async {
    await FirebaseFirestore.instance.collection("orders").doc(taxNum.toString()).update(
      {"status": status.toString()},
    );
    getRealTimeOrders();
    notifyListeners();
  }
}
