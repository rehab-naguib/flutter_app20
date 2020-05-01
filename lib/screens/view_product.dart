import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import './product_details.dart';
import './manage_products.dart';
import './orders.dart';
import './cart_items.dart';
import '../provider/cart.dart';

class ViewProduct extends StatefulWidget {
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<Product>(context, listen: false).getProducts();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => CartItems()));
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text(
                  "Cart",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Text(
                  "Favorite",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                value: 1,
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        elevation: 5,
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(
                "My Shop",
                style: TextStyle(fontSize: 20),
              ),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.shop),
                title: Text("Shop", style: TextStyle(fontSize: 15)),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewProduct()));
                }),
            Divider(),
            ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  "Manage Product",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ManageProduct()));
                }),
            Divider(),
            ListTile(
                leading: Icon(Icons.payment),
                title: Text("Orders", style: TextStyle(fontSize: 15)),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Orders()));
                }),
          ],
        ),
      ),
      body: isLoading
          ? CircularProgressIndicator(
              semanticsLabel: "Loading product...",
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: prodData.productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            ProductDetails(prodData.productList[index].id)));
                  },
                  child: GridTile(
//              child: Container(
//                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
//                height: 250,
//                width: 350,
//                decoration: BoxDecoration(
//                    color: Colors.red,
//                    borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(30),
//                        topRight: Radius.circular(30))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),

//
                      child: Image.network(
                        prodData.productList[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),

                    footer: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: GridTileBar(
                        backgroundColor: Colors.black87,
                        title:
                          Text(
                            prodData.productList[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,

                          ),
                        ),
                        leading: IconButton(
                            icon: Icon(
                              prodData.productList[index].fav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              prodData.toggleFav(prodData.productList[index].id,
                                  prodData.productList[index]);
                              print(prodData.productList[index].fav);
                            }),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                           Scaffold.of(context).removeCurrentSnackBar();
                           Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Added to cart",
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                            ));
                            int count = prodData.productList[index].amount +=1;
                            print(count);

                            if (count > 1) {
                              Provider.of<Cart>(context).updateItemCount(
                                  count, prodData.productList[index].id);
                            } else {
                              // prodData.productList[index].amount=count;
                              Provider.of<Cart>(context).addItem(
                                  prodData.productList[index].id,
                                  prodData.productList[index].title,
                                  prodData.productList[index].amount,
                                  prodData.productList[index].price);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
//                Stack(children: <Widget>[Container(
//                  //color: Co,lors.white
//                margin: const EdgeInsets.all(10),
//            height: 400,
//            width: 400,
//            decoration: BoxDecoration(
//              color: Colors.white,
//            borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(25),
//            topRight: Radius.circular(25))),
//            child: ClipRRect(
//
//            borderRadius: BorderRadius.only(
//            topRight: Radius.circular(25),
//            topLeft: Radius.circular(25)),
//
//                child: FittedBox(
//                  fit:BoxFit.cover,
//                  child: Image.network(
//                  prodData.productList[index].imageUrl,
//                  height: 100,
//
//
//
//            ),
//                ),),
//                ),
//                  //Positioned(bottom: 10,left: 20,child: Text(prodData.productList[index].title)),
//            Positioned(
//              left: 20,
//              bottom: 150,
//              child: Container(
//              width: 150,
//              child: Row(
//              children: <Widget>[
//              Text(prodData.productList[index].title),
//              Spacer(),
//              IconButton(
//              icon: Icon(Icons.favorite),
//              color: Colors.red,
//              ),
//              IconButton(
//              icon: Icon(Icons.shopping_cart),
//              ),
//              ],),),
//            ), ],
//
//
//
//            );
              }),
    );
  }
}
