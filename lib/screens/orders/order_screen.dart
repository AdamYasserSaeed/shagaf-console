// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shagf_console/core/providers/order_provider.dart';
import 'package:shagf_console/core/widgets/order_card.dart';
import 'package:shagf_console/core/widgets/title.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Order",
          style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //waiting orders
                  const TitleBar(title: 'Waiting'),
                  for (var order in orderProvider.orders.where((element) => element.status == "waiting")) Ordercard(order: order, ordersProvider: orderProvider),

                  //in progress
                  const TitleBar(title: 'inProgress'),
                  for (var order in orderProvider.orders.where((element) => element.status == "inProgress")) Ordercard(order: order, ordersProvider: orderProvider),

                  //on the way
                  const TitleBar(title: 'on the way'),
                  for (var order in orderProvider.orders.where((element) => element.status == "onTheWay")) Ordercard(order: order, ordersProvider: orderProvider),

                  //delivered
                  const TitleBar(title: 'Delivered'),
                  for (var order in orderProvider.orders.where((element) => element.status == "delivered")) Ordercard(order: order, ordersProvider: orderProvider),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
