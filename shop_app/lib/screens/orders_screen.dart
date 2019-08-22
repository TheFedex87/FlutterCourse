import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your orders'),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            print('State: ${dataSnapshot.connectionState}');
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error has occurred!'),
                );
              }
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) {
                  return ListView.builder(
                    itemCount: ordersData.itemCount,
                    itemBuilder: (ctx, index) =>
                        OrderItem(ordersData.orders[index]),
                  );
                },
              );
            }
          },
        ));
  }
}
