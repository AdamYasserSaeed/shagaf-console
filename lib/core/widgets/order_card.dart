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
                  "client name : " + widget.order.clientName,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                title: Text(
                  "client location : " + widget.order.clientLocation,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                title: GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(widget.order.clientLocationGoogleMap.toString()));
                  },
                  child: Text(
                    "client google maps URL : \n" + widget.order.clientLocationGoogleMap,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("tel:0" + widget.order.clientPhone.toString()));
                },
                title: Text(
                  "client phone : 0" + widget.order.clientPhone.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("tel:0" + widget.order.clientSparePhone.toString()));
                },
                title: Text(
                  "client spare phone : 0" + widget.order.clientSparePhone.toString(),
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
              (widget.order.status == "waiting")
                  ? Row(
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
                    )
                  : (widget.order.status == "inProgress")
                      ? Center(
                          child: SizedBox(
                            width: 150,
                            child: RaisedButton(
                              onPressed: () async {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          Center(
                                            child: SizedBox(
                                              width: 150,
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    widget.ordersProvider.changeStatus(widget.order.id, "onTheWay");
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                color: Colors.green,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Done",
                                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        title: const Text("choose delivery man"),
                                        content: Column(
                                          children: [
                                            for (var delivery in widget.ordersProvider.delivery)
                                              DeliveryCard(
                                                delivery: delivery,
                                                order: widget.order,
                                              ),
                                          ],
                                        ),
                                      );
                                    },
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
                                  "send to delivery man",
                                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      : (widget.order.status == "onTheWay")
                          ? Center(
                              child: SizedBox(
                                width: 150,
                                child: RaisedButton(
                                  onPressed: () async {
                                    setState(() {
                                      widget.ordersProvider.changeStatus(widget.order.id, "deliverd");
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.green,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "change to deliverd",
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ],
        title: Text("#" + widget.order.id.toString() + " / " + widget.order.status!),
      ),
    );
  }
}
