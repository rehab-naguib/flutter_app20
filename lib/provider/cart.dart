import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String id;
  final String title;
   int amount;
  final double price;
  double totalAmount;
  double totalOrder;
  List<Cart> cartItems = [];

  Cart({this.id,this.title, this.amount=0, this.price, this.totalAmount = 0,this.totalOrder=0});

  void addItem(String id,String title, int amount, double price) {

    double totalAmount=amount*price;
    cartItems.add(Cart(
      id: id,
      title: title,
      price: price,
      amount: amount,
      totalAmount: totalAmount,
    ));
    notifyListeners();
  }
  double getTotalOrder(){
    double total=0.0;
    cartItems.forEach((item){
      total+=item.totalAmount;
    });
    return total;
    notifyListeners();
  }
  void updateItemCount(int amount,String id){
    print("i'm here");
    if(amount>1) {
      int index = cartItems.indexWhere((item) => item.id == id);
      if(index>=0){
      cartItems[index].amount = amount;
      double priceItem = cartItems[index].price;
      double totalAmount = amount * priceItem;
      cartItems[index].totalAmount = totalAmount;
      notifyListeners();
    }}
  }

}
