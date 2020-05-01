import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String title;
  String time;
  double totalOrderPrice;
  final int quantity;
  double totalItemPrice;
  List<Order> orderList = [];

  Order({
    this.title,
    this.totalOrderPrice,
    this.quantity,
    this.totalItemPrice,
  });

  void getOrderList(
    String title,
    int quantity,
    double totalItemPrice,
  ) {
    orderList.add(Order(
        title: title,
        quantity: quantity,
        //time: time,

        totalItemPrice: totalItemPrice));
    orderList.forEach((order) {
      print(order.title);
    });
    notifyListeners();
  }

  void getTotalOrderPrice(double total) {
    totalOrderPrice = total;
    notifyListeners();
  }
}
