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
              for (var order in orderProvider.orders)
                Card(
                    child: ExpansionTile(
                  title: Text(order.clientName),
                )),
            ],
          ),
        ],
      ),
    );
  }
}
