import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final userId;

  Orders(
    this.authToken,
    this._orders,
    this.userId,
  );

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-shop-app-541b5.firebaseio.com/orders/$userId.json?auth=$authToken';
    final orders = await http.get(url);
    final extractedData = json.decode(orders.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    _orders.clear();
    extractedData.forEach((orderId, orderData) {
      _orders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map((product) => CartItem(
                  id: product['id'],
                  price: product['price'],
                  quantity: product['quantity'],
                  title: product['title'],
                ))
            .toList(),
      ));
    });
    _orders = _orders.reversed.toList();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  int get itemCount {
    return _orders.length;
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-shop-app-541b5.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map(
              (product) => {
                'id': product.id,
                'title': product.title,
                'quantity': product.quantity,
                'price': product.price,

              },
            )
            .toList(),
      }),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
