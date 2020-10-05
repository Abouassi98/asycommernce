import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  void auth({
    String email,
    String password,
    String userName,
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

      _storeUserData(responseData);

      print(responseData);
    }
    //  else {
    //   final errorMessage = responseData['error'];

    //   print("responseData:$errorMessage");
    // }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = responseData['user'];
    userData.putIfAbsent('jwt', () => responseData['jwt']);

    prefs.setString('user', json.encode(responseData['user']));
      prefs.setString('token', json.encode(responseData['jwt']));
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storeddata = prefs.getString('user');
    print("a7a=${json.encode(storeddata)}");
  }
}
