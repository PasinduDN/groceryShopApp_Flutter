import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier{
  final List _shopItems = [
    ["avacado", "1.99", "lib/images/avocado.png", Colors.green[100]],
    ["banana", "0.99", "lib/images/banana.png", Colors.yellow[100]],
    ["chicken", "5.99", "lib/images/chicken.png", Colors.brown[100]],
    ["water bottle", "0.49", "lib/images/waterBottle.png", Colors.blue[100]],
  ];

  List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0.0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}