// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shagf_console/screens/home/admin_home.dart';
import 'package:shagf_console/screens/home/home.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void login(userName, password, context) async {
    final data = await firestore.collection("users").get();
    for (var user in data.docs.where((element) =>
        element["name"] == userName && element["password"] == password)) {
      if (user.exists) {
        debugPrint(user["name"]);
        if (user["role"] == "admin") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      } else {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text("Error with user name or password")));
      }
    }
  }
}
