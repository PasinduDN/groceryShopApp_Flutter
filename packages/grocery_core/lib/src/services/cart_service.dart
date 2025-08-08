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

  // Helper function to manage loading state and automatically refresh the cart
  Future<void> _runAndUpdate(Future<void> Function(String userId) action) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await action(userId);
      // After every action, reload the cart from Firestore to ensure the UI is in sync.
      await loadCart(notify: false); // `notify: false` to avoid flicker
    } catch (e) {
      print("An error occurred in CartService: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Public method to load/refresh the cart
  Future<void> loadCart({bool notify = true}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    if (notify) {
      _isLoading = true;
      notifyListeners();
    }
    
    _cartItems = await cartRepository.getCart(userId);
    
    if (notify) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(GroceryItem groceryItem) async {
    await _runAndUpdate((userId) => cartRepository.addItemToCart(userId, groceryItem));
  }

  Future<void> increaseQuantity(String itemId) async {
    final item = cartItems.firstWhere((i) => i.groceryItem.id == itemId).groceryItem;
    await _runAndUpdate((userId) => cartRepository.addItemToCart(userId, item));
  }
  
  Future<void> decreaseQuantity(String itemId) async {
    await _runAndUpdate((userId) => cartRepository.decreaseItemQuantity(userId, itemId));
  }

  Future<void> clearCart() async {
    await _runAndUpdate((userId) => cartRepository.clearCart(userId));
  }
}