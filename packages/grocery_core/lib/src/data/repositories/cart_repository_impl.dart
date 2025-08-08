import '../../domain/entities/cart_item.dart';
import '../../domain/entities/grocery_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_firestore_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartFirestoreSource firestoreSource;

  CartRepositoryImpl({required this.firestoreSource});

  @override
  Future<void> addItemToCart(String userId, GroceryItem item) {
    return firestoreSource.addItem(userId, item);
  }

  @override
  Future<void> clearCart(String userId) {
    return firestoreSource.clear(userId);
  }

  @override
  Future<void> decreaseItemQuantity(String userId, String itemId) {
    return firestoreSource.decreaseQuantity(userId, itemId);
  }

  @override
  Future<List<CartItem>> getCart(String userId) {
    return firestoreSource.getCart(userId);
  }
}