import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order.dart';
import 'dart:math';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    int length = orderData.orderList.length;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "You Orders",
      )),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text( orderData.totalOrderPrice.toString()),
                    subtitle: Text(orderData.time),
                    trailing: IconButton(
                      icon: expanded
                          ? Icon(
                              Icons.expand_more,
                            )
                          : Icon(Icons.expand_less),
                      onPressed: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                    ),
                  ),

                  expanded?  Container(
                      height: min(length * 20.0 + 100, 180),
                      child: ListView.builder(
                        itemCount: orderData.orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                            child: Row(children: <Widget>[
                              Text(orderData.orderList[index].title,style: TextStyle(fontSize: 20,),),
                             Spacer(),
                              Text("${orderData.orderList[index].quantity
                                  .toString()}x"),
                              SizedBox(width: 5,),
                              Text("${orderData.orderList[index].totalItemPrice
                                  .toString()} L.E"),
                            ],),
                          );
                     /*     return ListTile(
                            title: Text(orderData.orderList[index].title),
                            trailing: Container(
                              width: 150,
                                child: Row(
                              children: <Widget>[
                                Text("${orderData.orderList[index].quantity
                                    .toString()}x"),
                                SizedBox(width: 10,),
                                Text(orderData.orderList[index].totalItemPrice
                                    .toString()),
                              ],
                            )),
                          );*/
                        },
                      ),
                    ):Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
