import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../domain/entities/cart_item.dart';
import '../domain/entities/grocery_item.dart';
import '../domain/repositories/cart_repository.dart';

class CartService extends ChangeNotifier {
  final CartRepository cartRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  CartService({required this.cartRepository}) {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        loadCart();
      } else {
        _cartItems = [];
        notifyListeners();
      }
    });
  }

  // Public getters
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  bool get isLoading => _isLoading;
  int get totalItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  String getFormattedTotal() => totalPrice.toStringAsFixed(2);

  Future<void> _runAndUpdate(Future<void> Function(String userId) action) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _isLoading = true;
    notifyListeners();

    await action(userId);
    // After the action, reload the cart from the database to ensure UI is in sync
    await loadCart();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCart() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    
    _isLoading = true;
    notifyListeners();

    _cartItems = await cartRepository.getCart(userId);
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItem(GroceryItem groceryItem) async {
    await _runAndUpdate((userId) => cartRepository.addItemToCart(userId, groceryItem));
  }
  
  Future<void> decreaseQuantity(String itemId) async {
    await _runAndUpdate((userId) => cartRepository.decreaseItemQuantity(userId, itemId));
  }

  Future<void> clearCart() async {
    await _runAndUpdate((userId) => cartRepository.clearCart(userId));
  }
}