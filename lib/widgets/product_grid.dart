import 'package:flutter/material.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/widgets/product_items.dart';

import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFav;

  ProductGrid({this.showOnlyFav});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showOnlyFav ? productsData.favItem : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItems(),
        );
      },
    );
  }
}
