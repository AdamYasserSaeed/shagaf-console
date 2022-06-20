import 'package:flutter/material.dart';
import 'package:shagf_console/screens/orders/order_screen.dart';
import 'package:shagf_console/screens/products/products.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: ListView(
            children: const [
              SizedBox(
                height: 200,
                child: Card(
                  color: Colors.amberAccent,
                ),
              ),
              ListTile(title: Text("Home")),
              ListTile(title: Text("Products")),
              ListTile(title: Text("Tables")),
              ListTile(title: Text("Sign out")),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Container(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _scaffoldKey.currentState?.openDrawer();
          });
        },
        child: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.black, width: 2)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsScreen()));
                  },
                  child: SizedBox(
                    height: 250,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Products",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network("https://cdn-icons-png.flaticon.com/512/1170/1170577.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.black, width: 2)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
                  },
                  child: SizedBox(
                    height: 250,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Orders",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network("https://cdn-icons-png.flaticon.com/512/1356/1356594.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
