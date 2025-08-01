import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;

  GroceryItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(12.0),  
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              height: 100,
              width: 100,
            ),
            Text(itemName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              onPressed: onPressed,
              color: Color.fromARGB(255, 65, 211, 143),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "\$$itemPrice",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}