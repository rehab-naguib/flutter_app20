import 'package:flutter/material.dart';
import './orders.dart';
import '../provider/product.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';
import '../provider/order.dart';
import 'package:intl/intl.dart';

class CartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              elevation: 4,
              child: ListTile(
                leading: Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Container(
                  width: 250,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Chip(
                          label: Text(
                            cartData.getTotalOrder().toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blueAccent),
                      FlatButton(
                        child: Text(
                          "ORDER NOW",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () {
                          var orderData = Provider.of<Order>(context);
                          cartData.cartItems.forEach((item) {
                            orderData.getOrderList(
                                item.title, item.amount, item.totalAmount);
                            orderData.totalOrderPrice = (item.getTotalOrder());
                            orderData.time =
                                DateFormat.yMMMd().format(DateTime.now());
                          });
                        //  cartData.cartItems.forEach((item) => item.amount = 0);
                          cartData.cartItems.clear();
//                          print(cartData.cartItems);
//                          print(cartData.cartItems.length);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => Orders()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartData.cartItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.all(5),
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 45,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10),
                    ),
                    key: Key(cartData.cartItems[index].id),
                    confirmDismiss: (_) {
                      return showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              content: Text("Do you want To Delete ?",
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              title: Text("Delete",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              elevation: 4,
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    cartData.cartItems.removeAt(index);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          cartData.cartItems[index].title,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          cartData.cartItems[index].totalAmount.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Text(
                            "${cartData.cartItems[index].amount.toString()}x",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
