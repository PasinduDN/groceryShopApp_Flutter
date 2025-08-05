import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_core/grocery_core.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... (Your AppBar code)
      ),
      body: Consumer<CartService>( // Consume the CartService
        builder: (context, cartService, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Your "My Cart" title)

              Expanded(
                child: ListView.builder(
                  itemCount: cartService.cartItems.length,
                  padding: EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    final cartItem = cartService.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      // ... (Your existing item padding and container)
                      child: ListTile(
                        leading: Image.asset(
                          cartItem.groceryItem.imagePath,
                          height: 50,
                          width: 50,
                        ),
                        title: Text(cartItem.groceryItem.name),
                        subtitle: Text(
                          "Price: \$${cartItem.groceryItem.price.toStringAsFixed(2)} x ${cartItem.quantity}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => cartService.removeItem(cartItem.groceryItem.id),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ... (Your total price and "Pay Now" button)
              // Update the total calculation to use the service
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  // ... (Styling)
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 159, 66, 66))),
                          const SizedBox(height: 4),
                          Text('\$${cartService.getFormattedTotal()}', style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 159, 66, 66))),
                        ],
                      ),
                      // ... ("Pay Now" button)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}