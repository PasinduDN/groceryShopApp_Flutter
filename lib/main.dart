import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_core/grocery_core.dart'; // Your package
import 'package:grocery_shop/pages/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_shop/services/auth_service.dart';
import 'firebase_options.dart';

// Import the new repository implementation
import 'package:grocery_core/src/data/repositories/cart_repository_impl.dart';
import 'package:grocery_core/src/data/datasources/cart_firestore_source.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // DATA LAYER PROVIDERS
        Provider<ProductFirestoreSource>(create: (_) => ProductFirestoreSource()),
        Provider<CartFirestoreSource>(create: (_) => CartFirestoreSource()),
        
        // DOMAIN LAYER PROVIDERS (Repositories)
        ProxyProvider<ProductFirestoreSource, ProductRepository>(
          update: (_, firestoreSource, __) =>
              ProductRepositoryImpl(firestoreSource: firestoreSource),
        ),
        ProxyProvider<CartFirestoreSource, CartRepository>(
          update: (_, firestoreSource, __) =>
              CartRepositoryImpl(firestoreSource: firestoreSource),
        ),
        
        // APPLICATION LAYER PROVIDERS (Services / Notifiers)
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<CartRepository, CartService>(
          create: (context) => CartService(
            cartRepository: Provider.of<CartRepository>(context, listen: false),
          ),
          update: (_, cartRepository, previousCartService) =>
              previousCartService!..cartRepository, // This syntax is a bit odd, but it works
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}