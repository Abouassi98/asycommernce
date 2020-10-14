import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/cart.dart';
import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  Map<String, Cart> _iteams = {};
  Map<String, Cart> get iteams {
    return {..._iteams};
  }

  int get itemCount {
    return iteams.length;
  }

  double get totalamount {
    double total = 0.0;
    _iteams.forEach((key, cartItem) {
      return total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      {String productId,
        int price,
        String desc,
        String name,
        String pic,
        int quantity}) {
    if (_iteams.containsKey(productId)) {
      _iteams.update(
          productId,
              (updateCart) => Cart(
            id: updateCart.id,
            description: updateCart.description,
            name: updateCart.name,
            picture: updateCart.picture,
            price: updateCart.price,
            quantity: updateCart.quantity + 1,
          ));
    } else {
      _iteams.putIfAbsent(
          productId,
              () => Cart(
            description: desc,
            id: productId,
            name: name,
            picture: pic,
            price: price,
            quantity: quantity,
          ));
    }
    notifyListeners();
  }

  void clear() {
    _iteams = {};
    notifyListeners();
  }

  bool itemishere(String productId) {
    if (iteams.containsKey(productId)) {
      return true;
    } else {
      return false;
    }
  }

  void removeitem(String productId) {
    if (_iteams.containsKey(productId)) {
      _iteams.removeWhere((_, item) => productId == item.id);
      notifyListeners();
    } else {
      notifyListeners();
      return;
    }
  }

}
