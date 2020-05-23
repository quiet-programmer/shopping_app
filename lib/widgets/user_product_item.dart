import 'package:flutter/material.dart';

class UserProductItems extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItems(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                    onPressed: null),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
