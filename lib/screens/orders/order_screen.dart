// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/providers/order_provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    setState(() {
      final orderProvider = context.read<OrdersProvider>();
      orderProvider.getRealTimeOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrdersProvider>();

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Order",
                style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //waiting orders

                  for (var order in orderProvider.orders.where((element) => element.status == "waiting"))
                    Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: ExpansionTile(children: [
                        ExpansionTile(
                          children: [
                            for (var ordereditem in order.items)
                              ListTile(
                                subtitle: Text(
                                  "x" + ordereditem.count.toString(),
                                ),
                                title: Text(
                                  ordereditem.name.toString(),
                                ),
                              ),
                            Text(
                              "client name : ",
                              style: TextStyle(),
                            )
                          ],
                          title: const Text("Items"),
                        ),
                      ], title: Text("#" + order.id.toString() + " / " + order.status!)),
                    ),

                  // //in progress
                  // for (var order in orderProvider.orders.where((element) => element.status == "inProgress"))
                  //   Card(
                  //     color: Colors.grey,
                  //     child: ExpansionTile(children: [
                  //       FlatButton(
                  //           onPressed: () {
                  //             orderProvider.changeStatus(order.id, "delevered");
                  //           },
                  //           child: const Text("change status")),
                  //       for (var ordereditem in order.items)
                  //         Text(
                  //           ordereditem.name.toString(),
                  //         ),
                  //     ], title: Text(order.clientName + " / " + order.status!)),
                  //   ),
                  const Divider(),
                  const Text(
                    "delivered",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Divider(),
                  //delivered
                  for (var order in orderProvider.orders.where((element) => element.status == "delivered"))
                    Card(
                      color: Colors.green,
                      child: ExpansionTile(
                        children: [
                          FlatButton(
                            onPressed: () {
                              orderProvider.changeStatus(order.id, "delivered");
                            },
                            child: const Text(
                              "change status",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          for (var ordereditem in order.items)
                            Text(
                              ordereditem.name.toString(),
                            ),
                        ],
                        title: Text(
                          order.clientName + " / " + order.status!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
