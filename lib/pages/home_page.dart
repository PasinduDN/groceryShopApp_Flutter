import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_core/grocery_core.dart';
import 'package:grocery_shop/components/grocery_item_tile.dart';
import 'package:grocery_shop/pages/cart_page.dart';
import 'package:grocery_shop/services/auth_service.dart'; // Import AuthService
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // We set listen: false here because we only need to access the services,
    // not rebuild the entire HomePage when they change.
    final groceryService = Provider.of<GroceryService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      // Add an AppBar to hold the title and the new sign-out button.
      appBar: AppBar(
        title: const Text('Grocery Shop'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // This is the new Sign Out Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call the signOut method from your AuthService
              authService.signOut();
            },
          ),
        ],
      ),
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
            const SizedBox(height: 24), // Adjusted for AppBar

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

            // Using a FutureBuilder to handle the async call to Firestore
            Expanded(
              child: FutureBuilder<List<GroceryItem>>(
                future: groceryService.getAllItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong!'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No items found.'));
                  }

                  final items = snapshot.data!;
                  return GridView.builder(
                    itemCount: items.length,
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GroceryItemTile(
                          itemName: item.name,
                          itemPrice: item.price.toStringAsFixed(2),
                          imagePath: item.imagePath,
                          color: item.backgroundColor,
                          onPressed: () {
                            Provider.of<CartService>(context, listen: false)
                                .addItem(item);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item.name} added to cart!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          });
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