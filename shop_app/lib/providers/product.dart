import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  bool isTogglingFavorite = false;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteState(String authToken, String userId) async {
    final url =
        'https://flutter-shop-app-541b5.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';

    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Error updating favorite status.');
      }
    } catch (error) {
      isFavorite = !isFavorite;
      notifyListeners();
      print(error);
      //throw HttpException('Error updating favorite state');
    }
  }
}
