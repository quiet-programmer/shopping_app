import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  final String id;

  EditProductScreen({this.id});
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _priceFocus = FocusNode();
  final _desFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  TextEditingController _imageController = TextEditingController();

  var _isInit = true;
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  var _editedProduct = Products(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final productId = widget.id;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValue = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl
          'imageUrl': ''
        };
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(_updateImageUrl);
    _priceFocus.dispose();
    _desFocus.dispose();
    _imageController.dispose();
    _imageUrlFocus.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      if (!_imageController.text.startsWith("http") &&
          !_imageController.text.startsWith("https")) {
        return;
      }

      if (!_imageController.text.endsWith('png') &&
          !_imageController.text.endsWith('jpg') &&
          !_imageController.text.endsWith('jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Prodcut"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return value.isEmpty ? "Please enter a Title" : null;
                },
                onSaved: (value) {
                  _editedProduct = Products(
                    id: _editedProduct.id,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite
                  );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _initValue['price'],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                validator: (value) {
                  var price = double.tryParse(value);
                  if (value.isEmpty) {
                    return "Please enter a Price";
                  }

                  if (price == null) {
                    return "Please enter a valid number eg: 10.00";
                  }

                  if (double.parse(value) <= 0) {
                    return "Plase enter number greater than 0";
                  }

                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Products(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite
                  );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_desFocus);
                },
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _initValue['description'],
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _desFocus,
                validator: (value) {
                  return value.isEmpty ? "Please enter a Description" : null;
                },
                onSaved: (value) {
                  _editedProduct = Products(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite
                  );
                },
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageController.text.isEmpty
                        ? Text("Enter a Url")
                        : FittedBox(
                            child: Image.network(
                              _imageController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageController,
                      focusNode: _imageUrlFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter an image url";
                        }
                        if (!value.startsWith("http") &&
                            !value.startsWith("https")) {
                          return "Please enter a valid URL";
                        }

                        if (!value.endsWith('png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('jpeg')) {
                          return "Please enter a valid image url";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                          isFavorite: _editedProduct.isFavorite
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      decoration: InputDecoration(
                        labelText: "Image Url",
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
