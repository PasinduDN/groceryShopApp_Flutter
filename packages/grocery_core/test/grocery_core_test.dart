// import 'package:flutter_test/flutter_test.dart';
// import 'package:grocery_core/grocery_core.dart';
// import 'package:flutter/material.dart';

// void main() {
//   group('GroceryService Tests', () {
//     late GroceryService groceryService;

//     setUp(() {
//       groceryService = GroceryService();
//     });

//     test('should return all grocery items', () {
//       final items = groceryService.getAllItems();
//       expect(items.length, 4);
//     });

//     test('should return items by category', () {
//       final fruitItems = groceryService.getItemsByCategory('Fruits');
//       expect(fruitItems.length, 2);
//       expect(fruitItems.every((item) => item.category == 'Fruits'), true);
//     });

//     test('should return item by ID', () {
//       final item = groceryService.getItemById('1');
//       expect(item, isNotNull);
//       expect(item!.name, 'Avocado');
//     });

//     test('should return null for non-existent ID', () {
//       final item = groceryService.getItemById('999');
//       expect(item, isNull);
//     });

//     test('should search items by name', () {
//       final results = groceryService.searchItems('avo');
//       expect(results.length, 1);
//       expect(results.first.name, 'Avocado');
//     });

//     test('should return all categories', () {
//       final categories = groceryService.getCategories();
//       expect(categories.contains('Fruits'), true);
//       expect(categories.contains('Meat'), true);
//       expect(categories.contains('Beverages'), true);
//     });
//   });

//   group('CartService Tests', () {
//     late CartService cartService;
//     late GroceryItem testItem;

//     setUp(() {
//       cartService = CartService();
//       cartService.clearCart(); // Clear cart before each test
      
//       testItem = const GroceryItem(
//         id: 'test1',
//         name: 'Test Item',
//         price: 2.99,
//         imagePath: 'test/path.png',
//       );
//     });

//     test('should add item to cart', () {
//       cartService.addItem(testItem);
//       expect(cartService.cartItems.length, 1);
//       expect(cartService.totalItemCount, 1);
//       expect(cartService.totalPrice, 2.99);
//     });

//     test('should increase quantity when adding existing item', () {
//       cartService.addItem(testItem);
//       cartService.addItem(testItem);
      
//       expect(cartService.cartItems.length, 1);
//       expect(cartService.totalItemCount, 2);
//       expect(cartService.totalPrice, 5.98);
//     });

//     test('should remove item from cart', () {
//       cartService.addItem(testItem);
//       cartService.removeItem(testItem.id);
      
//       expect(cartService.cartItems.length, 0);
//       expect(cartService.totalItemCount, 0);
//       expect(cartService.totalPrice, 0.0);
//     });

//     test('should update item quantity', () {
//       cartService.addItem(testItem);
//       cartService.updateItemQuantity(testItem.id, 3);
      
//       expect(cartService.totalItemCount, 3);
//       expect(cartService.totalPrice, 8.97);
//     });

//     test('should remove item when quantity updated to 0', () {
//       cartService.addItem(testItem);
//       cartService.updateItemQuantity(testItem.id, 0);
      
//       expect(cartService.cartItems.length, 0);
//     });

//     test('should increase and decrease quantity', () {
//       cartService.addItem(testItem);
//       cartService.increaseQuantity(testItem.id);
      
//       expect(cartService.totalItemCount, 2);
      
//       cartService.decreaseQuantity(testItem.id);
//       expect(cartService.totalItemCount, 1);
//     });

//     test('should clear entire cart', () {
//       cartService.addItem(testItem);
//       cartService.clearCart();
      
//       expect(cartService.cartItems.length, 0);
//       expect(cartService.totalItemCount, 0);
//     });

//     test('should calculate tax correctly', () {
//       cartService.addItem(testItem); // $2.99
//       final tax = cartService.calculateTax(); // 8% default
//       expect(tax, closeTo(0.24, 0.01));
//     });

//     test('should calculate total with tax', () {
//       cartService.addItem(testItem); // $2.99
//       final totalWithTax = cartService.getTotalWithTax(); // 8% default
//       expect(totalWithTax, closeTo(3.23, 0.01));
//     });
//   });

//   group('GroceryItem Tests', () {
//     test('should create GroceryItem from JSON', () {
//       final json = {
//         'id': '1',
//         'name': 'Test Item',
//         'price': 1.99,
//         'imagePath': 'test.png',
//         'description': 'Test description',
//         'category': 'Test',
//         'isAvailable': true,
//       };

//       final item = GroceryItem.fromJson(json);
//       expect(item.id, '1');
//       expect(item.name, 'Test Item');
//       expect(item.price, 1.99);
//       expect(item.description, 'Test description');
//     });

//     test('should convert GroceryItem to JSON', () {
//       const item = GroceryItem(
//         id: '1',
//         name: 'Test Item',
//         price: 1.99,
//         imagePath: 'test.png',
//         description: 'Test description',
//         category: 'Test',
//       );

//       final json = item.toJson();
//       expect(json['id'], '1');
//       expect(json['name'], 'Test Item');
//       expect(json['price'], 1.99);
//       expect(json['description'], 'Test description');
//     });

//     test('should create copy with modified properties', () {
//       const original = GroceryItem(
//         id: '1',
//         name: 'Original',
//         price: 1.99,
//         imagePath: 'test.png',
//       );

//       final copy = original.copyWith(name: 'Modified', price: 2.99);
//       expect(copy.id, '1'); // unchanged
//       expect(copy.name, 'Modified'); // changed
//       expect(copy.price, 2.99); // changed
//       expect(copy.imagePath, 'test.png'); // unchanged
//     });
//   });
// }
