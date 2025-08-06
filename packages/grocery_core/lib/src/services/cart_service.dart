import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/grocery_item.dart';

class CartService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CartItem> _cartItems = [];

  CartService() {
    // Listen to authentication changes.
    // When a user logs in, load their cart. When they log out, clear the local cart.
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _loadCartFromFirestore(user.uid);
      } else {
        _cartItems.clear();
        notifyListeners();
      }
    });
  }

  // Public getters
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  int get totalItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  String getFormattedTotal() => totalPrice.toStringAsFixed(2);

  // Helper to get the path to the user's cart subcollection
  CollectionReference _getCartCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('cart');
  }

  // Fetches the user's cart from Firestore when they log in
  Future<void> _loadCartFromFirestore(String userId) async {
    try {
      final snapshot = await _getCartCollection(userId).get();
      _cartItems = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartItem.fromJson(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error loading cart from Firestore: $e");
    }
  }

  // Adds an item to the cart and syncs with Firestore
  void addItem(GroceryItem groceryItem) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return; // Exit if no user is logged in

    final existingIndex = _cartItems.indexWhere((item) => item.groceryItem.id == groceryItem.id);

    if (existingIndex != -1) {
      // Item already exists, so update its quantity
      final updatedItem = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
      _cartItems[existingIndex] = updatedItem;
      // Update the document in Firestore
      await _getCartCollection(userId).doc(groceryItem.id).set(updatedItem.toJson());
    } else {
      // Item is new, add it to the cart
      final newItem = CartItem(
        groceryItem: groceryItem,
        quantity: 1,
        addedAt: DateTime.now(),
      );
      _cartItems.add(newItem);
      // Create a new document in Firestore
      await _getCartCollection(userId).doc(groceryItem.id).set(newItem.toJson());
    }
    notifyListeners();
  }

  // Decreases item quantity or removes it, syncing with Firestore
  void decreaseQuantity(String itemId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    
    final index = _cartItems.indexWhere((item) => item.groceryItem.id == itemId);
    if (index != -1) {
      final currentItem = _cartItems[index];
      if (currentItem.quantity > 1) {
        // If quantity is more than 1, just decrease it
        final updatedItem = currentItem.copyWith(quantity: currentItem.quantity - 1);
        _cartItems[index] = updatedItem;
        await _getCartCollection(userId).doc(itemId).set(updatedItem.toJson());
      } else {
        // If quantity is 1, remove the item
        _cartItems.removeAt(index);
        await _getCartCollection(userId).doc(itemId).delete();
      }
      notifyListeners();
    }
  }

  // Clears the entire cart and removes all items from Firestore
  void clearCart() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Delete all documents in the user's cart subcollection
    final cartSnapshot = await _getCartCollection(userId).get();
    for (var doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }

    _cartItems.clear();
    notifyListeners();
  }

  // A convenience method to call addItem, which handles the logic for increasing quantity
  void increaseQuantity(String itemId) {
    final item = _cartItems.firstWhere((item) => item.groceryItem.id == itemId);
    addItem(item.groceryItem);
  }
}