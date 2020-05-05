import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String id;

  ProductDetailScreen({this.id});
  @override
  Widget build(BuildContext context) {
    final loadedProducts =
        Provider.of<ProductsProvider>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
    );
  }
}
