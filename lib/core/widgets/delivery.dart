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
              Center(
                child: SizedBox(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        launchUrl(
                          Uri.parse(
                            "https://web.whatsapp.com/send/?phone=%2B962${widget.delivery.phone}&text="
                                    "%0aاسم العميل : " +
                                widget.order.clientName.toString() +
                                "%0aرقم هاتف : " +
                                widget.order.clientPhone.toString() +
                                "%0aرقم احتياطي : " +
                                widget.order.clientSparePhone.toString() +
                                "%0aموقع العميل : " +
                                widget.order.clientLocation +
                                "%0aرابط موقع العميل : " +
                                widget.order.clientLocationGoogleMap.toString() +
                                "%0aملخص الطلب : " +
                                order! +
                                "%0aالمجموع الكلي : " +
                                widget.order.total.toString() +
                                "%0aالمعرف : " +
                                widget.order.id.toString(),
                          ),
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.yellow,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "forward order",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
