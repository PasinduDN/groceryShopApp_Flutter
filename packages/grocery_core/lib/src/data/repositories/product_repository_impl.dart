import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/grocery_item.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/utils/result.dart'; // Import Result
import '../datasources/product_firestore_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductFirestoreSource firestoreSource;

  ProductRepositoryImpl({required this.firestoreSource});

  @override
  Future<Result<List<GroceryItem>, Exception>> getAllProducts() async {
    try {
      final products = await firestoreSource.getAllProducts();
      // Return a Success object on success
      return Success(products);
    } on FirebaseException catch (e) {
      // Catch specific Firebase errors and return a user-friendly message
      print("A Firebase error occurred: ${e.code} - ${e.message}");
      return Failure(Exception("Failed to load products. Please check your connection."));
    } catch (e) {
      // Catch any other generic errors
      print("An unexpected error occurred: $e");
      return Failure(Exception("An unexpected error occurred. Please try again later."));
    }
  }
}