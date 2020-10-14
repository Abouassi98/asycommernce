import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class Auth with ChangeNotifier {
 
  String email;
  String userName;
  String token;
  void auth({
    email,
    String password,
    userName,
    bool login,
    var responseData,
  }) async {
    http.Response response = await http.post(
        login
            ? 'http://192.168.1.2:1337/auth/local'
            : 'http://192.168.1.2:1337/auth/local/register',
        body: login
            ? {'identifier': email, 'password': password}
            : {'username': userName, 'email': email, 'password': password});
    responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      print("responseData:$responseData");

      await _storeUserData(responseData);
      notifyListeners();
      print(responseData);
    }
  }

  Future<void> _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = responseData['user'];
    userData.putIfAbsent('jwt', () => responseData['jwt']);
    await prefs.setString('user', json.encode(responseData['user']));
    await prefs.setString('token', json.encode(responseData['jwt']));
  }

  Future<dynamic> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storData = prefs.getString('user');

    final users =
        storData != null ? User.fromJson(json.decode(storData)) : null;

    notifyListeners();
    return users;
  }

  Future<bool> tryAutoAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user')) {
      return false;
    }
    final extractData =
        json.decode(prefs.getString('user')) as Map<String, dynamic>;
    email = extractData['email'];
    userName = extractData['username'];
    token = extractData['jwt'];
    notifyListeners();
    return true;
  }
}
