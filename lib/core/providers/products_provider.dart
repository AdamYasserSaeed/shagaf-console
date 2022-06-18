// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shagf_console/core/models/item_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Item> products = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getItemsFromDB() async {
    final data = await firestore.collection("items").get();

    products.clear();

    for (var item in data.docs) {
      products.add(
        Item(
          name: item["name"],
          price: double.parse(item["price"].toString()),
          description: item["description"],
          id: item["id"].toString(),
          imgURL: item["img"],
          category: item["category"],
          count: int.parse(item["count"].toString()),
        ),
      );
      notifyListeners();
    }
  }

  void editProduct(Item selectedItem, context) async {
    final data = firestore.collection("items");

    final dbItem = data.doc(selectedItem.id);

    dbItem.update({
      "category": selectedItem.category,
      "count": selectedItem.count,
      "description": selectedItem.description,
      "img": selectedItem.imgURL,
      "name": selectedItem.name,
      "price": selectedItem.price,
      "total": 0,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Updated Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    notifyListeners();
  }

  void addProduct(name, price, id, count, imgURL, des, category, context) async {
    final data = firestore.collection("items");

    await data.add({
      "id": id,
      "category": category,
      "count": count,
      "description": des,
      "img": imgURL,
      "name": name,
      "price": price,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Added Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    notifyListeners();
  }

  void deleteProduct(Item selectedItem, context) async {
    final data = firestore.collection("items");

    final dbItem = data.doc(selectedItem.id);

    dbItem.delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "deleted Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    notifyListeners();
  }

  void viewImage(imageURL) {}
}
