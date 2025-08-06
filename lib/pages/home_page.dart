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
    final groceryService = Provider.of<GroceryService>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartPage();
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
            const SizedBox(height: 48),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Good Morning"),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Let's order fresh items for you",
                style: GoogleFonts.notoSerif(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Fresh Items", style: TextStyle(fontSize: 16)),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: groceryService.getAllItems().length,
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
                        Provider.of<CartService>(context, listen: false)
                            .addItem(item);

                        // Show a SnackBar for user feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} added to cart!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}