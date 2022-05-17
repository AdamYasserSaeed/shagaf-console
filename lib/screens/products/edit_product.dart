// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/models/item_model.dart';
import 'package:shagf_console/core/providers/products_provider.dart';
import 'package:shagf_console/core/widgets/edit_button.dart';

class EditProduct extends StatefulWidget {
  final Item item;

  const EditProduct({Key? key, required this.item}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();

    final product = widget.item;

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
          Text(
            "Edit " + widget.item.name,
            style: const TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: widget.item.name),
              onSubmitted: (val) {
                setState(() {
                  product.name = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: product.price.toString()),
              onSubmitted: (val) {
                setState(() {
                  product.price = double.parse(val);
                });
              },
              decoration: const InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: product.category),
              onSubmitted: (val) {
                setState(() {
                  product.category = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "category",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: product.count.toString()),
              onSubmitted: (val) {
                setState(() {
                  product.count = int.parse(val);
                });
              },
              decoration: const InputDecoration(
                labelText: "min count",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: product.description),
              onSubmitted: (val) {
                setState(() {
                  product.description = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "description",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: TextEditingController(text: product.imgURL),
              onSubmitted: (val) {
                setState(() {
                  product.imgURL = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "img URL",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditButton(
                name: "Delete",
                bgColor: Colors.red,
                txtColor: Colors.white,
                onPress: () {
                  productsProvider.deleteProduct(product, context);
                },
              ),
              EditButton(
                name: "Cancel",
                bgColor: Colors.blue,
                txtColor: Colors.white,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              EditButton(
                name: "Save",
                bgColor: Colors.green,
                txtColor: Colors.white,
                onPress: () {
                  productsProvider.editProduct(product, context);
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
