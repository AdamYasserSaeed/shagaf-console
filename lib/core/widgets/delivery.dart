// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shagf_console/core/models/delivery_model.dart';
import 'package:shagf_console/core/models/order_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCard extends StatefulWidget {
  final Delivery delivery;
  final Order order;
  const DeliveryCard({
    Key? key,
    required this.delivery,
    required this.order,
  }) : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  String? order = "";

  @override
  void initState() {
    for (var item in widget.order.items) {
      order = order! + "\nname : ${item.name}\ncount : ${item.count}\nprice : ${item.price}\ntotal : ${item.price}\n____________________\n";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "name : " + widget.delivery.name.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("tel:" + widget.delivery.phone.toString()));
                },
                title: Text(
                  "phone : " + widget.delivery.phone.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ],
        title: Text(widget.delivery.name.toString()),
      ),
    );
  }
}
