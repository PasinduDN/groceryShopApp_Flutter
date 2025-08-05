import 'package:flutter/foundation.dart';
import '../models/grocery_item.dart';
import '../models/cart_item.dart';

/// Service for managing shopping cart operations
class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _cartItems = [];

  /// Get all cart items
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  /// Get total number of items in cart
  int get totalItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  /// Get total price of all items in cart
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Check if item exists in cart
  bool isItemInCart(String itemId) {
    return _cartItems.any((cartItem) => cartItem.groceryItem.id == itemId);
  }

  /// Get quantity of specific item in cart
  int getItemQuantity(String itemId) {
    final cartItem = _cartItems
        .where((item) => item.groceryItem.id == itemId)
        .firstOrNull;
    return cartItem?.quantity ?? 0;
  }

  /// Add item to cart
  void addItem(GroceryItem groceryItem, {int quantity = 1}) {
    final existingIndex = _cartItems
        .indexWhere((item) => item.groceryItem.id == groceryItem.id);

    if (existingIndex != -1) {
      // Item already exists, update quantity
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      _cartItems.add(CartItem(
        groceryItem: groceryItem,
        quantity: quantity,
        addedAt: DateTime.now(),
      ));
    }
    notifyListeners();
  }

  /// Remove item from cart completely
  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.groceryItem.id == itemId);
    notifyListeners();
  }

  /// Update item quantity
  void updateItemQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(itemId);
      return;
    }

    final index = _cartItems
        .indexWhere((item) => item.groceryItem.id == itemId);
    
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  /// Increase item quantity by 1
  void increaseQuantity(String itemId) {
    final index = _cartItems
        .indexWhere((item) => item.groceryItem.id == itemId);
    
    if (index != -1) {
      final currentItem = _cartItems[index];
      _cartItems[index] = currentItem.copyWith(
        quantity: currentItem.quantity + 1,
      );
      notifyListeners();
    }
  }

  /// Decrease item quantity by 1
  void decreaseQuantity(String itemId) {
    final index = _cartItems
        .indexWhere((item) => item.groceryItem.id == itemId);
    
    if (index != -1) {
      final currentItem = _cartItems[index];
      if (currentItem.quantity > 1) {
        _cartItems[index] = currentItem.copyWith(
          quantity: currentItem.quantity - 1,
        );
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Get cart summary
  Map<String, dynamic> getCartSummary() {
    return {
      'totalItems': totalItemCount,
      'totalPrice': totalPrice,
      'itemCount': _cartItems.length,
      'items': _cartItems.map((item) => item.toJson()).toList(),
    };
  }

  /// Calculate tax (8% by default)
  double calculateTax({double taxRate = 0.08}) {
    return totalPrice * taxRate;
  }

  /// Calculate total with tax
  double getTotalWithTax({double taxRate = 0.08}) {
    return totalPrice + calculateTax(taxRate: taxRate);
  }

  /// Get formatted total price
  String getFormattedTotal() {
    return totalPrice.toStringAsFixed(2);
  }

  /// Get formatted total with tax
  String getFormattedTotalWithTax({double taxRate = 0.08}) {
    return getTotalWithTax(taxRate: taxRate).toStringAsFixed(2);
  }
}
