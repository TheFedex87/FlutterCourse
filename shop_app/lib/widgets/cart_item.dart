import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String productId;

  CartItem(
    this.id,
    this.title,
    this.quantity,
    this.price,
    this.productId,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$${price.toStringAsFixed(2)}'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('x $quantity'),
          trailing: Chip(
            label: Text(
              '\$${(quantity * price).toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.title.color,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
