// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shagf_console/core/models/order_model.dart';
import 'package:shagf_console/core/providers/order_provider.dart';
import 'package:shagf_console/core/widgets/delivery.dart';
import 'package:url_launcher/url_launcher.dart';

class Ordercard extends StatefulWidget {
  final Order order;
  final OrdersProvider ordersProvider;
  const Ordercard({Key? key, required this.order, required this.ordersProvider}) : super(key: key);

  @override
  State<Ordercard> createState() => _OrdercardState();
}

class _OrdercardState extends State<Ordercard> {
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
                  "table number : " + widget.order.tableNum.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                title: Text(
                  "time : " + widget.order.time!,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                title: Text(
                  "note : " + widget.order.note!,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ExpansionTile(
                children: [
                  for (var ordereditem in widget.order.items)
                    ListTile(
                      subtitle: Text(
                        "x" + ordereditem.count.toString(),
                      ),
                      leading: Text(ordereditem.total.toString() + "JD"),
                      title: Text(
                        ordereditem.name.toString(),
                      ),
                    ),
                ],
                title: const Text(
                  "Items",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                title: Text(
                  "total : " + widget.order.total.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                title: Text(
                  "total : " + widget.order.total.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          widget.ordersProvider.changeStatus(widget.order.id, "inProgress");
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.green,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "accept",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          widget.ordersProvider.changeStatus(widget.order.id, "reject");
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "reject",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ],
        title: Text("table Num" + widget.order.tableNum.toString()),
      ),
    );
  }
}
