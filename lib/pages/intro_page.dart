import 'package:flutter/material.dart';

import 'package:shopping_cart/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0, right: 80, bottom: 40, top: 100),
          child: Image.asset('lib/images/splash.png'),
        ),
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "We deliver groceries at your doorstep",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          'Fresh items everyday...',
          style: TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        const Spacer(),
      ],
    ));
  }
}
