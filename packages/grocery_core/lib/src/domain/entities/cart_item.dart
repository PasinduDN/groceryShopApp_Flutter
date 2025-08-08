import 'grocery_item.dart';

/// Represents a cart item with quantity
class CartItem {
  final GroceryItem groceryItem;
  final int quantity;
  final DateTime addedAt;

  const CartItem({
    required this.groceryItem,
    required this.quantity,
    required this.addedAt,
  });

  /// Calculate total price for this cart item
  double get totalPrice => groceryItem.price * quantity;

  /// Create a copy with modified properties
  CartItem copyWith({
    GroceryItem? groceryItem,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      groceryItem: groceryItem ?? this.groceryItem,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  /// Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      groceryItem: GroceryItem.fromJson(json['groceryItem']),
      quantity: json['quantity'] ?? 1,
      addedAt: DateTime.parse(json['addedAt']),
    );
  }

  /// Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'groceryItem': groceryItem.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && 
           other.groceryItem == groceryItem &&
           other.quantity == quantity;
  }

  @override
  int get hashCode => groceryItem.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'CartItem(item: ${groceryItem.name}, quantity: $quantity, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}
