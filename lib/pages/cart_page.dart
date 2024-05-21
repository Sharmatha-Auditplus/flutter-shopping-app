import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/cart_item.dart';
import 'package:shopping_cart/pages/bottom_navigation_page.dart';
import 'package:shopping_cart/pages/checkout_page.dart';
import 'package:shopping_cart/pages/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int selectedIndex = 0;
  bool get isCartEmpty => items.isEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: const BackButton(color: Colors.black),
            title: const Text(
              'Shopping Cart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: isCartEmpty
                ? null
                : FlexibleSpaceBar(
                    background: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Subtotal ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0.0, -3.0),
                                    child: const Text(
                                      '₹',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 186, 30, 30),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(getTotalPrice()),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 186, 30, 30),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          if (!isCartEmpty)
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CheckoutPage()),
                        ).then((_) => setState(() {}));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.green[50]!),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Proceed to Buy', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
            ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: isCartEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your cart is empty...',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Icon(Icons.shopping_cart, color: Colors.green, size: 40),
                      ],
                    ),
                  )
                : Column(
                    children: items.map((CartItem item) {
                      return ListTile(
                        leading: Image.network(item.product.imgUrl!, width: 50, height: 50),
                        title: Text(item.product.name),
                        subtitle: Row(
                          children: [
                            const Text(
                              '₹',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              item.subtotal.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity -= 1;
                                  } else {
                                    removeFromCart(item.batch.id);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  item.quantity += 1;
                                });
                              },
                              icon: const Icon(Icons.add, color: Colors.green),
                            ),
                          
                            // IconButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       removeFromCart(item.product.id);
                            //     });
                            //   },
                            //   icon: const Icon(Icons.delete, color: Colors.black),
                            // )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationPage(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => setState(() {
          selectedIndex = index;
        }),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
