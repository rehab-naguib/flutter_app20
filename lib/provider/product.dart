import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool fav;

  List<Product> productList = [];

  Product(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.imageUrl,
      this.fav = false});

  Future<void> addProduct(Product product) async {
    //print(product.fav);
    const url = 'https://shop-app-11263.firebaseio.com/products.json';
    final response = await http.post(url,
        body: json.encode({
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "fav": product.fav,
          //"id": json.decode(response.body)['name']
        }));
    // print(response.body);
    final newProduct = Product(
      id: json.decode(response.body)['name'],
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      title: product.title,
      //fav:product.fav
    );
    productList.add(newProduct);
    productList.forEach((element) => print(element.id));
    notifyListeners();
  }

  Future<void> getProducts() async {
    const url = 'https://shop-app-11263.firebaseio.com/products.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Product> fetchedList = [];
    extractedData.forEach((prodId, prodData) {
      fetchedList.add(Product(
          id: prodId,
          title: prodData["title"],
          price: prodData["price"],
          description: prodData["description"],
          imageUrl: prodData["imageUrl"]));
    });
    productList = fetchedList;
    notifyListeners();
  }

  Product findByID(String id) {
    final index = productList.indexWhere((prod) => prod.id == id);
    return productList[index];
  }

  Future<void> updateProduct(String id, Product prod) async {
    final url = 'https://shop-app-11263.firebaseio.com/products/$id.json';
    final index = productList.indexWhere((prodId) => prodId.id == id);
    if (index >= 0) {
      await http.patch(url,
          body: json.encode(
            {
              "title": prod.title,
              "price": prod.price,
              "description": prod.description,
              "imageUrl": prod.imageUrl
            },
          ));
      productList[index] = prod;

      notifyListeners();
    } else {
      print("000");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://shop-app-11263.firebaseio.com/products/$id.json';
    await http.delete(url);
    productList.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
