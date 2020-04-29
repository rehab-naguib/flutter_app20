import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //static const  routName="add_product";
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  bool isLoading = false;
  String id;

  //This uniquely identifies the Form, and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    title: "",
    price: 0.0,
    imageUrl: "",
    description: "",
    id: "",
  );
  var init = true;
  var initialValues = {
    "title": "",
    "price": "",
    "imageUrl": "",
    "description": "",
    "id": ""
  };

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _editedProduct =
            Provider.of<Product>(context, listen: false).findByID(id);
        initialValues["title"] = _editedProduct.title;
        initialValues["price"] = _editedProduct.price.toString();
        initialValues["description"] = _editedProduct.description;
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    init = false;
    super.didChangeDependencies();
  }

  void _saveForm() async {
    final isValidate = _formKey.currentState.validate();
    if (!isValidate) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

  //  if (_editedProduct.id == null) {
      //  print(_editedProduct.fav);
  //    print(_editedProduct.id);
      await Provider.of<Product>(context, listen: false)
          .addProduct(_editedProduct);
    /* else {
      //     print(_editedProduct.fav);
      print(_editedProduct.id);
      await Provider.of<Product>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    }
*/
    setState(
      () {
        isLoading = false;
      },
    );
    Navigator.of(context).pop();
    //print(Provider.of<Product>(context, listen: false).getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add new product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(11.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initialValues["title"],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter a title';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value,
                            fav: _editedProduct.fav,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: initialValues["price"],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please Enter Price";
                        } else if (double.tryParse(value) == null) {
                          return "Enter a valid price";
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Price",
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            fav: _editedProduct.fav,
                            price: double.parse(value),
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: initialValues["description"],
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please provide a description";
                        } else if (value.length < 10) {
                          return "Enter at least 10 characters";
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            fav: _editedProduct.fav,
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: value,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 6, left: 2, right: 5),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: _imageController.text.isEmpty
                              ? Center(
                                  child: Text("Please enter url"),
                                )
                              : FittedBox(
                                  child: Image.network(_imageController.text),
                                  fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter a URL";
                              } else if (!(value.startsWith("http") ||
                                  value.startsWith("https"))) {
                                return "Enter a valid URL";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Image URL",
                            ),
                            keyboardType: TextInputType.url,
                            controller: _imageController,
                            textInputAction: TextInputAction.done,
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  fav: _editedProduct.fav,
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: value);
                            },
                            /* onEditingComplete: (){
                      setState(() {

                      });
                    },*/
//                        onFieldSubmitted: (_) {
//                          setState(() {});
//                        },
                            onChanged: (_) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
