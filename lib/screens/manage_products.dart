import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../screens/add_product.dart';

class ManageProduct extends StatefulWidget {

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  void initState() {
    Provider.of<Product>(context,listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Manage Products"),actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct()));
          },)
        ],),
    body:ListView.builder(
      itemCount: productData.productList.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage(productData.productList[index].imageUrl),
              //     child: Image.network(productData.productList[index].imageUrl),
            ),
            title: Text(productData.productList[index].title),
            trailing: Container(
              width: 100,
              child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/addProduct",arguments: productData.productList[index].id);
                    },
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        productData.deleteProduct(productData.productList[index].id);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    ),);
  }
}







