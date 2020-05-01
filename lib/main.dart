import 'package:flutter/material.dart';
import './screens/add_product.dart';
import './provider/product.dart';
import 'package:provider/provider.dart';
import './screens/manage_products.dart';
import './screens/view_product.dart';
import './provider/cart.dart';
import 'provider/order.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(builder: (ctx)=>Product(),),
        ChangeNotifierProvider(builder: (ctx)=>Cart(),),
        ChangeNotifierProvider(builder: (ctx)=>Order(),),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "./",
        routes: {
          "./":(context)=>ViewProduct(),
          "/manageProduct":(contex)=>ManageProduct(),
          "/addProduct":(context)=>AddProduct(),

        }
        ,

      ),
    );
  }}
//}class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title:Text("hello"),),
//      body: Container(child: Text("hi there!",style: TextStyle(fontSize: 23,color: Colors.amber),textAlign: TextAlign.center,),),
//    );
//  }
//}
