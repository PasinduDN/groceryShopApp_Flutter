import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/components/grocery_item_tile.dart';
import 'package:grocery_core/grocery_core.dart'; 
import 'package:grocery_shop/pages/cart_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the services from the provider
    final groceryService = Provider.of<GroceryService>(context, listen: false);
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 175, 178, 221),
        child: const Icon(Icons.shopping_bag),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (Your existing UI code for titles and dividers)

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Fresh Items", style: TextStyle(fontSize: 16)),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: groceryService.getAllItems().length, // Get items from service
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = groceryService.getAllItems()[index];
                  return GroceryItemTile(
                    itemName: item.name,
                    itemPrice: item.price.toStringAsFixed(2),
                    imagePath: item.imagePath,
                    color: item.backgroundColor,
                    onPressed: () {
                      // Use CartService to add items
                      Provider.of<CartService>(context, listen: false).addItem(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}