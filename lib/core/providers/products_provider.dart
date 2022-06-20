// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, unused_local_variable, avoid_print

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shagf_console/core/models/item_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Item> products = [];

  String? imageName = "";
  Uint8List? rawImage;

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
          count: 1,
        ),
      );
      notifyListeners();
    }
  }

  void editProduct(Item selectedItem, context) async {
    final data = firestore.collection("items");

    final dbItem = data.doc(selectedItem.id);

    print(selectedItem.id);

    dbItem.update({
      "category": selectedItem.category,
      "count": 1,
      "id": selectedItem.id,
      "description": selectedItem.description,
      "img": imageName,
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

    getItemsFromDB();

    notifyListeners();
  }

  void addProduct(name, price, des, category, context) async {
    final data = firestore.collection("items");

    await fb.FirebaseStorage.instance.ref(imageName).putData(rawImage!);

    await data.add({
      "category": category,
      "count": 1,
      "description": des,
      "img": imageName,
      "name": name,
      "price": price,
    });

    final doc = await data.where("name", isEqualTo: name).get();

    for (var item in doc.docs) {
      data.doc(item.id).update({"id": doc.docs.length});
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Added Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    getItemsFromDB();

    notifyListeners();
  }

  Future<Uri> downloadURL(context, String imgName) async {
    final String url = await fb.FirebaseStorage.instance.refFromURL("gs://shagf-console.appspot.com").child(imgName).getDownloadURL();

    if (imgName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("no img found"),
        ),
      );
    }

    return Uri.parse(url);
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

    getItemsFromDB();

    notifyListeners();
  }

  void uploadeImage(context) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg"],
    );

    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("no file selected"),
        ),
      );
      return null;
    }

    try {
      Uint8List fileBytes = results.files.first.bytes!;

      String filename = results.files.first.name.toString();
      Uint8List rawData = fileBytes.buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes);

      rawImage = rawData;
      imageName = filename;
    } catch (e) {
      debugPrint(e.toString());
    }

    // final path = results.files.single.path;
    // final fileName = results.files.single.name;

    // print(path);
    // print(fileName);
    notifyListeners();
  }
}
