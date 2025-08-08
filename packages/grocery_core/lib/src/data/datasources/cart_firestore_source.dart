import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/grocery_item.dart';

class CartFirestoreSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getCartCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('cart');
  }

  Future<List<CartItem>> getCart(String userId) async {
    final snapshot = await _getCartCollection(userId).get();
    return snapshot.docs.map((doc) {
      return CartItem.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addItem(String userId, GroceryItem item) async {
    final cartRef = _getCartCollection(userId).doc(item.id);
    final snapshot = await cartRef.get();

    if (snapshot.exists) {
      // If item exists, increment quantity
      final existingItem = CartItem.fromJson(snapshot.data() as Map<String, dynamic>);
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      await cartRef.set(updatedItem.toJson());
    } else {
      // If item is new, add it
      final newItem = CartItem(groceryItem: item, quantity: 1, addedAt: DateTime.now());
      await cartRef.set(newItem.toJson());
    }
  }

  Future<void> decreaseQuantity(String userId, String itemId) async {
    final cartRef = _getCartCollection(userId).doc(itemId);
    final snapshot = await cartRef.get();

    if (snapshot.exists) {
      final existingItem = CartItem.fromJson(snapshot.data() as Map<String, dynamic>);
      if (existingItem.quantity > 1) {
        // If quantity is more than 1, decrease it
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity - 1);
        await cartRef.set(updatedItem.toJson());
      } else {
        // If quantity is 1, remove it
        await cartRef.delete();
      }
    }
  }

  Future<void> clear(String userId) async {
    final cartSnapshot = await _getCartCollection(userId).get();
    for (var doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}