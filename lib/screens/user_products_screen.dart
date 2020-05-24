import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';
import 'package:shopping_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return EditProductScreen();
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) {
            return UserProductItems(id: productData.items[index].id,title: productData.items[index].title, imageUrl:productData.items[index].imageUrl);
          },
        ),
      ),
    );
  }
}
