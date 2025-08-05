import 'package:flutter/material.dart';
import '../models/grocery_item.dart';

/// Service for managing grocery items and inventory
class GroceryService {
  static final GroceryService _instance = GroceryService._internal();
  factory GroceryService() => _instance;
  GroceryService._internal();

  // Sample data - you can replace this with API calls or database
  List<GroceryItem> _groceryItems = [
    GroceryItem(
      id: '1',
      name: 'Avocado',
      price: 1.99,
      imagePath: 'lib/images/avocado.png',
      backgroundColor: Colors.green[100],
      description: 'Fresh and creamy avocados',
      category: 'Fruits',
    ),
    GroceryItem(
      id: '2',
      name: 'Banana',
      price: 0.99,
      imagePath: 'lib/images/banana.png',
      backgroundColor: Colors.yellow[100],
      description: 'Sweet yellow bananas',
      category: 'Fruits',
    ),
    GroceryItem(
      id: '3',
      name: 'Chicken',
      price: 5.99,
      imagePath: 'lib/images/chicken.png',
      backgroundColor: Colors.brown[100],
      description: 'Fresh chicken breast',
      category: 'Meat',
    ),
    GroceryItem(
      id: '4',
      name: 'Water Bottle',
      price: 0.49,
      imagePath: 'lib/images/waterBottle.png',
      backgroundColor: Colors.blue[100],
      description: 'Pure drinking water',
      category: 'Beverages',
    ),
  ];

  /// Get all grocery items
  List<GroceryItem> getAllItems() {
    return List.unmodifiable(_groceryItems);
  }

  /// Get items by category
  List<GroceryItem> getItemsByCategory(String category) {
    return _groceryItems
        .where((item) => item.category == category)
        .toList();
  }

  /// Get item by ID
  GroceryItem? getItemById(String id) {
    try {
      return _groceryItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search items by name
  List<GroceryItem> searchItems(String query) {
    if (query.isEmpty) return getAllItems();
    
    return _groceryItems
        .where((item) => 
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            (item.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();
  }

  /// Get all categories
  List<String> getCategories() {
    return _groceryItems
        .map((item) => item.category ?? 'Others')
        .toSet()
        .toList();
  }

  /// Add new item (for admin functionality)
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
  }

  /// Update item
  bool updateItem(GroceryItem updatedItem) {
    final index = _groceryItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _groceryItems[index] = updatedItem;
      return true;
    }
    return false;
  }

  /// Remove item
  bool removeItem(String id) {
    final index = _groceryItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _groceryItems.removeAt(index);
      return true;
    }
    return false;
  }

  /// Get available items only
  List<GroceryItem> getAvailableItems() {
    return _groceryItems.where((item) => item.isAvailable).toList();
  }
}
