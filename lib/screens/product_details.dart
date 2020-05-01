import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/cart.dart';

class ProductDetails extends StatelessWidget {
  final String id;

  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
    final getData = Provider.of<Product>(context);
    final product = getData.findByID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.fitWidth,
                )),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Align(
                  //alignment: Alignment.topLeft,
                  child: Text(
                    " ${product.price} L.E",
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  // alignment: Alignment.topLeft,
                  child: Text(
                    " ${product.description}",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(
                  builder: (context) => FlatButton(
                    child: Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 20),
                    ),
                    // shape: CircleBorder(),

                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Added to cart",textAlign: TextAlign.center,),

                      ));
                      int index = getData.productList
                          .indexWhere((prod) => prod.id == id);
                      int count = getData.productList[index].amount += 1;
                      print(product.id);
                      if (count <= 1)
                        Provider.of<Cart>(context).addItem(
                            product.id,
                            product.title,
                            getData.productList[index].amount,
                            getData.productList[index].price);
                      else {
                        Provider.of<Cart>(context).updateItemCount(
                            getData.productList[index].amount,
                            getData.productList[index].id);
                      }
                    },

                    // elevation: 5,
                    padding: const EdgeInsets.all(10),
                    //color: Colors.blueAccent,
                    textColor: Colors.blueAccent,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
