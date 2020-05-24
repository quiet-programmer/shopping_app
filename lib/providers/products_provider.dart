import 'package:flutter/material.dart';
import 'package:shopping_app/providers/products.dart';

class ProductsProvider with ChangeNotifier {
  //list of items
  List<Products> _items = [
    Products(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Products(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Products(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Products(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

// to get the items from the private List variable.
  List<Products> get items {
    return [..._items];
  }

// to get the favorite items i user selected.
  List<Products> get favItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

// getting a product by id.
  Products findById(String id) {
    return _items.firstWhere(
      (prod) => prod.id == id,
    );
  }

  void addProduct(Products products) {
    final newProduct = Products(
      id: DateTime.now().toString(),
      title: products.title,
      description: products.description,
      price: products.price,
      imageUrl: products.imageUrl,
    );

    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String productId, Products newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == productId);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String prodcutId) {
    _items.removeWhere((prod) => prod.id == prodcutId);
    notifyListeners();
  }
}
