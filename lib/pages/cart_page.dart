import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/model/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
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
                  itemCount: cartModel.cartItems.length,
                  padding: EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            cartModel.cartItems[index][2],
                            height: 50,
                            width: 50,
                          ),
                          title: Text(cartModel.cartItems[index][0]),
                          subtitle: Text(
                            "Price: \$${cartModel.cartItems[index][1]}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () => Provider.of<CartModel>(context, listen: false)
                                .removeItemFromCart(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration (
                    color: const Color.fromARGB(255, 229, 155, 155),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 159, 66, 66))),
                          const SizedBox(height: 4),
                          Text('\$${cartModel.calculateTotal()}', style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 159, 66, 66))),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          // color: const Color.fromARGB(255, 65, 211, 143),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: const[
                            Text("Pay Now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                          ],
                        ),
                      )
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
