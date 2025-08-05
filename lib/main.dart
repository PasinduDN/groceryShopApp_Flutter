import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'package:grocery_core/grocery_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide an instance of GroceryService
        Provider(create: (context) => GroceryService()),
        // CartService extends ChangeNotifier, so it can be used with ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => CartService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}