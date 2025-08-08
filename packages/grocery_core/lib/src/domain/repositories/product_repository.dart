import '../entities/grocery_item.dart';
import '../utils/result.dart'; // Import the new Result type

// This is an abstract class that defines the contract for fetching products.
// The UI will depend on this, not the concrete implementation.
abstract class ProductRepository {
  // Now returns a Future that resolves to either a list of items or an exception
  Future<Result<List<GroceryItem>, Exception>> getAllProducts();
}