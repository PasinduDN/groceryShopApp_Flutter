library grocery_core;

// --- DOMAIN LAYER ---
// Entities (Models)
export 'src/domain/entities/grocery_item.dart';
export 'src/domain/entities/cart_item.dart';

// Repositories (Abstract Contracts)
export 'src/domain/repositories/product_repository.dart';
export 'src/domain/repositories/cart_repository.dart';

// Utils (Error Handling, etc.)
export 'src/domain/utils/result.dart';


// --- DATA LAYER ---
// We need to export these so the main app can create and provide them.
export 'src/data/datasources/product_firestore_source.dart';
export 'src/data/datasources/cart_firestore_source.dart';
export 'src/data/repositories/product_repository_impl.dart';
export 'src/data/repositories/cart_repository_impl.dart';


// --- APPLICATION / SERVICE LAYER ---
export 'src/services/cart_service.dart';