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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Order",
            style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              //waiting orders

              for (var order in orderProvider.orders.where((element) => element.status == "waiting"))
                Card(
                  color: Colors.red,
                  child: ExpansionTile(children: [
                    FlatButton(
                        onPressed: () {
                          orderProvider.changeStatus(order.id, "delevered");
                        },
                        child: const Text("change status")),
                    for (var ordereditem in order.items)
                      Text(
                        ordereditem.name.toString(),
                      ),
                  ], title: Text(order.clientName + " / " + order.status!)),
                ),

              //in progress
              for (var order in orderProvider.orders.where((element) => element.status == "inProgress"))
                Card(
                  color: Colors.grey,
                  child: ExpansionTile(children: [
                    FlatButton(
                        onPressed: () {
                          orderProvider.changeStatus(order.id, "delevered");
                        },
                        child: const Text("change status")),
                    for (var ordereditem in order.items)
                      Text(
                        ordereditem.name.toString(),
                      ),
                  ], title: Text(order.clientName + " / " + order.status!)),
                ),

              //delivered
              for (var order in orderProvider.orders.where((element) => element.status == "delivered"))
                Card(
                  color: Colors.green,
                  child: ExpansionTile(children: [
                    FlatButton(
                        onPressed: () {
                          orderProvider.changeStatus(order.id, "delevered");
                        },
                        child: const Text("change status")),
                    for (var ordereditem in order.items)
                      Text(
                        ordereditem.name.toString(),
                      ),
                  ], title: Text(order.clientName + " / " + order.status!)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
