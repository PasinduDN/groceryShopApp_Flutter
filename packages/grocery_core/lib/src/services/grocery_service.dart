import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/grocery_item.dart';

class GroceryService {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  /// Get all grocery items from Firestore
  Future<List<GroceryItem>> getAllItems() async {
    try {
      QuerySnapshot snapshot = await _productsCollection.get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Color? bgColor;
        if (data['backgroundColor'] != null) {
          // THE FIX IS HERE: Ensure the number is treated as an integer
          bgColor = Color((data['backgroundColor'] as num).toInt());
        } else {
          bgColor = Colors.grey[200];
        }

        return GroceryItem(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          imagePath: data['imagePath'] ?? '',
          backgroundColor: bgColor,
          description: data['description'] ?? '',
          category: data['category'] ?? '',
        );
      }).toList();
    } catch (e) {
      print("Error fetching items: $e");
      return []; // Return an empty list if there's an error
    }
  }

  // You can update the other methods later to also use Firestore.
  // For now, we are just fixing the getAllItems method.

  /// Get items by category
  List<GroceryItem> getItemsByCategory(String category) {
    // This would need to be updated to a Firestore query
    return [];
  }

  /// Get item by ID
  GroceryItem? getItemById(String id) {
    // This would need to be updated to a Firestore query
    return null;
  }
}