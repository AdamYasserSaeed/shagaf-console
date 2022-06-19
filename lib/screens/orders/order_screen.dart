// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/providers/order_provider.dart';
import 'package:shagf_console/core/widgets/order_card.dart';
import 'package:shagf_console/core/widgets/title.dart';

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
      orderProvider.getDeliveryMen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrdersProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                orderProvider.getRealTimeOrders();
              },
              icon: const Icon(Icons.refresh))
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Order",
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //waiting orders
              for (var order in orderProvider.orders
                  .where((element) => element.status == "waiting"))
                Ordercard(order: order, ordersProvider: orderProvider),
            ],
          ),
        ),
      ),
    );
  }
}
