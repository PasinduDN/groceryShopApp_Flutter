import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 140.0, bottom: 20.0),
            child: Image.asset('lib/images/avocado.png'),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 24.0),
            child: Text(
              'We deliver groceries at your doorstep',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSerif(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text("Fresh Items everyday",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[600],
            ),
          ),
          
          const Spacer(),

          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage(); // Assuming you have a HomePage widget to navigate to
                },
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 108, 3, 103),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: const Text("Get Started",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
