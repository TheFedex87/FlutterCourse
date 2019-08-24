import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authentication(
      String email, String password, String segment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$segment?key=AIzaSyDT_5j0QKoEw0WXu7YKlCduKJqG_05XWDE";
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final respondeData = json.decode(response.body);
      if (respondeData['error'] != null) {
        throw HttpException(respondeData['error']['message']);
      }
      _token = respondeData['idToken'];
      _userId = respondeData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            respondeData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, "signInWithPassword");
  }
}
