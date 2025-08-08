import 'package:flutter/material.dart';

/// Represents a grocery item with all its properties
class GroceryItem {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final Color? backgroundColor;
  final String? description;
  final String? category;
  final bool isAvailable;
  
  const GroceryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.backgroundColor,
    this.description,
    this.category,
    this.isAvailable = true,
  });

  /// Create GroceryItem from JSON
  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imagePath: json['imagePath'] ?? '',
      backgroundColor: json['backgroundColor'] != null 
          ? Color(json['backgroundColor']) 
          : null,
      description: json['description'],
      category: json['category'],
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  /// Convert GroceryItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'backgroundColor': backgroundColor?.value,
      'description': description,
      'category': category,
      'isAvailable': isAvailable,
    };
  }

  /// Create a copy with modified properties
  GroceryItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
    Color? backgroundColor,
    String? description,
    String? category,
    bool? isAvailable,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      description: description ?? this.description,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroceryItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'GroceryItem(id: $id, name: $name, price: $price)';
  }
}
