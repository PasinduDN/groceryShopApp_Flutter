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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "My Cart",
                  style: GoogleFonts.notoSerif(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartService.cartItems.length,
                  padding: const EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    final cartItem = cartService.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            cartItem.groceryItem.imagePath,
                            height: 50,
                            width: 50,
                          ),
                          title: Text(cartItem.groceryItem.name),
                          subtitle: Text(
                            '\$${cartItem.groceryItem.price.toStringAsFixed(2)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartService.decreaseQuantity(
                                      cartItem.groceryItem.id);
                                },
                              ),
                              Text(
                                cartItem.quantity.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartService.increaseQuantity(
                                      cartItem.groceryItem.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: GestureDetector(
                  onTap: () {
                    // Show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Payment Successful'),
                        content: const Text('Your order has been placed.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Clear the cart
                              cartService.clearCart();
                              // Close the dialog
                              Navigator.of(context).pop();
                              // Go back to the home page
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 229, 155, 155),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Total Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Color.fromARGB(255, 159, 66, 66))),
                            const SizedBox(height: 4),
                            Text('\$${cartService.getFormattedTotal()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color:
                                        Color.fromARGB(255, 159, 66, 66))),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: const [
                              Text("Pay Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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