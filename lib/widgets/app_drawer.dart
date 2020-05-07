import 'package:flutter/material.dart';
import 'package:shopping_app/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Text(
                "Shopping App",
                style: TextStyle(
                  fontSize: 25.0
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Payment"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return OrdersScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
