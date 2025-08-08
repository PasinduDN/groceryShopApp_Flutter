import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/grocery_item.dart';

class ProductFirestoreSource {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<GroceryItem>> getAllProducts() async {
    try {
      final snapshot = await _productsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        Color? bgColor;
        if (data['backgroundColor'] != null) {
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
      print("Error fetching items from Firestore: $e");
      // In a real app, you'd want more robust error handling
      return [];
    }
  }
}