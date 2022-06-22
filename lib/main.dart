import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/providers/login_provider.dart';
import 'package:shagf_console/core/providers/order_provider.dart';
import 'package:shagf_console/core/providers/products_provider.dart';
import 'package:shagf_console/screens/home/admin_home.dart';
import 'package:shagf_console/screens/login/login.dart';
import 'package:shagf_console/screens/products/add_product.dart';
import 'package:shagf_console/screens/products/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyBEfXjqap2M47gsTdYcJMEGvt1iwEVH0kY",
      authDomain: "shagf-console.firebaseapp.com",
      projectId: "shagf-console",
      storageBucket: "shagf-console.appspot.com",
      messagingSenderId: "104517493217",
      appId: "1:104517493217:web:10a42c02e1c8f9ae8172a0",
      measurementId: "G-1WNJ54TR4B",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => ProductsProvider()),
          ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ],
        builder: (context, _) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: HomeBody(),
            ),
          );
        });
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return const AdminHomeScreen();
  }
}
