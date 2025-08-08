import '../entities/cart_item.dart';
import '../entities/grocery_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCart(String userId);
  Future<void> addItemToCart(String userId, GroceryItem item);
  Future<void> decreaseItemQuantity(String userId, String itemId);
  Future<void> clearCart(String userId);
}