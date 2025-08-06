import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_core/grocery_core.dart';
import 'package:grocery_shop/pages/auth_wrapper.dart';
import 'package:grocery_shop/pages/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_shop/services/auth_service.dart';
import 'firebase_options.dart';

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
        Provider(create: (context) => GroceryService()),
        ChangeNotifierProvider(create: (context) => CartService()),
        // Provide the new AuthService
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // Start with the IntroPage
        home: IntroPage(),
      ),
    );
  }
}