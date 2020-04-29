import 'package:flutter/material.dart';
import './screens/add_product.dart';
import './provider/product.dart';
import 'package:provider/provider.dart';
import './screens/manage_products.dart';
import 'package:device_preview/device_preview.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx)=>Product(),
      child: MaterialApp(
        initialRoute: "./",
        routes: {
          "./":(context)=>ManageProduct(),
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
