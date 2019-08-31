import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exceptions.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    /*Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  final String authToken;

  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((prod) => prod.id == productId);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = 'https://flutter-shop-app-541b5.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final products = await http.get(url);
      final extractedData = json.decode(products.body) as Map<String, dynamic>;
      if(extractedData == null) {
        return;
      }
      url = 'https://flutter-shop-app-541b5.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteRsponse = await http.get(url);
      final favoriteData = json.decode(favoriteRsponse.body);
      _items.clear();
      extractedData.forEach((prodId, prodData) {
        _items.add(Product(
          id: prodId,
          title: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://flutter-shop-app-541b5.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'creatorId': userId,
        }),
      );

      final newProduct = Product(
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-shop-app-541b5.firebaseio.com/products/$id.json?auth=$authToken';
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'price': newProduct.price,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }),
        );
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    } else {
      print('...');
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-shop-app-541b5.firebaseio.com/products/$id.json?auth=$authToken';
    // Example of Optimistic updating: remove from local, but before store a reference to the object and if remote update fails, restore the local object to the list
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    // Delete does not throws an error, so if we want check for an error we have to read response status code
    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
