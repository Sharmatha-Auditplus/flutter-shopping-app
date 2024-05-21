import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/home_page.dart';

class BottomNavigationPage extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const BottomNavigationPage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
      if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.green[200],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              const Icon(Icons.shopping_cart),
              if (items.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 14,
                      minWidth: 14,
                    ),
                    child: Text(
                      '${items.fold(0, (previousValue, current) => previousValue + current.quantity)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
      ],
    );
  }
}
