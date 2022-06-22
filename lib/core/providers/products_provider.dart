// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, unused_local_variable, avoid_print

import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shagf_console/core/models/category_model.dart';
import 'package:shagf_console/core/models/item_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Item> products = [];
  List<CategoryModel> cateogryies = [];

  String? imageName = "";
  Uint8List? rawImage;
  String? eimageName = "";
  Uint8List? erawImage;

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

    await fb.FirebaseStorage.instance.ref(eimageName).putData(erawImage!);

    await dbItem.update({
      "category": selectedItem.category,
      "count": 1,
      "id": selectedItem.id,
      "description": selectedItem.description,
      "img": eimageName,
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

    Navigator.pop(context);
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
      await data.doc(item.id).update({"id": item.id});
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Added Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    getItemsFromDB();

    Timer(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });

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

    await dbItem.delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "deleted Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));

    getItemsFromDB();

    Timer(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
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
  }

  void uploadeImageEdit(context) async {
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
      eimageName = "";
      erawImage = null;
      erawImage = rawData;
      eimageName = filename;
    } catch (e) {
      debugPrint(e.toString());
    }

    // final path = results.files.single.path;
    // final fileName = results.files.single.name;

    // print(path);
    // print(fileName);
    notifyListeners();
  }

  void addCategoryPOPUP(context) {
    String? dropdownButtonValue = "A";

    String? categoryName = "";

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text("Add Category"),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              categoryName = val;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'category name',
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text("Arrange of item : "),
                            DropdownButton<String>(
                              value: dropdownButtonValue,
                              items: const [
                                DropdownMenuItem(child: Text("A"), value: "A"),
                                DropdownMenuItem(child: Text("B"), value: "B"),
                                DropdownMenuItem(child: Text("C"), value: "C"),
                              ],
                              onChanged: (String? val) {
                                setState(() {
                                  dropdownButtonValue = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        addCategory(categoryName, dropdownButtonValue, context);
                      },
                      child: const Text("Add Category"))
                ],
              );
            }));
  }

  void addCategory(String? categoryName, String? placeInList, context) async {
    final data = firestore.collection("categories");

    await data.add({
      "name": categoryName,
      "placeInList": placeInList,
      "id": "",
    });

    final doc = await data.where("name", isEqualTo: categoryName).get();

    for (var category in doc.docs) {
      await data.doc(category.id).update({"id": category.id});
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Added Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));
    Navigator.pop(context);
  }

  void showEditCategory(context, CategoryModel categoryModel) {
    String? newName = "";
    String? newPlaceInList = categoryModel.placeInList;

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("Edit ${categoryModel.name}"),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              newName = val;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: categoryModel.name,
                            border: const OutlineInputBorder(),
                            labelText: 'category name',
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text("Arrange of item : "),
                            DropdownButton<String>(
                              value: newPlaceInList,
                              items: const [
                                DropdownMenuItem(child: Text("A"), value: "A"),
                                DropdownMenuItem(child: Text("B"), value: "B"),
                                DropdownMenuItem(child: Text("C"), value: "C"),
                              ],
                              onChanged: (String? val) {
                                setState(() {
                                  newPlaceInList = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        editCategory(categoryModel, newName, newPlaceInList, context);
                      },
                      child: const Text("Apply Changes"))
                ],
              );
            }));
  }

  void editCategory(CategoryModel categoryModel, name, palceInList, context) async {
    final data = firestore.collection("categories");

    await data.doc(categoryModel.id).update({
      "name": name,
      "placeInList": palceInList,
      "id": categoryModel.id,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Edit Sucsessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));
    Navigator.pop(context);
  }

  void showCategories(context) async {
    final data = await firestore.collection("categories").get();

    cateogryies.clear();

    for (var categories in data.docs) {
      cateogryies.add(CategoryModel(name: categories["name"], placeInList: categories["placeInList"]));
      notifyListeners();
    }

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text("Categories"),
                content: SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                        children: cateogryies
                            .map((e) => ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      showEditCategory(context, e);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  title: Text(e.name ?? "no name found"),
                                  subtitle: Text("place in list : " + (e.placeInList ?? "A")),
                                ))
                            .toList()),
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Done"))
                ],
              );
            }));
  }
}
