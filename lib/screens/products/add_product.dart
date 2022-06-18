// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/models/item_model.dart';
import 'package:shagf_console/core/providers/products_provider.dart';
import 'package:shagf_console/core/widgets/edit_button.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    final data = FirebaseFirestore.instance.collection("items");

    TextEditingController? nameC = TextEditingController();
    TextEditingController? priceC = TextEditingController();
    TextEditingController? categoryC = TextEditingController();
    TextEditingController? minCountC = TextEditingController();
    TextEditingController? desC = TextEditingController();
    TextEditingController? imgURLC = TextEditingController();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425__340.png",
              )),
          SizedBox(width: 20),
        ],
        title: const Text(
          "Shagf admin panel",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Add New Product",
            style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nameC,
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: priceC,
              decoration: const InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: categoryC,
              decoration: const InputDecoration(
                labelText: "category",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: minCountC,
              decoration: const InputDecoration(
                labelText: "min count",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: desC,
              decoration: const InputDecoration(
                labelText: "description",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: imgURLC,
              decoration: const InputDecoration(
                labelText: "img URL",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditButton(
                name: "Cancel",
                bgColor: Colors.red,
                txtColor: Colors.white,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              EditButton(
                name: "Add",
                bgColor: Colors.green,
                txtColor: Colors.white,
                onPress: () async {
                  await data.add({
                    "id": Random().nextInt(1000),
                    "category": categoryC.text,
                    "count": minCountC.text,
                    "description": desC.text,
                    "img": imgURLC.text,
                    "name": nameC.text,
                    "price": priceC.text,
                  });
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Added Sucsessfully",
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
