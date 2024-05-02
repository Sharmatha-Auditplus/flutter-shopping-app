import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/cart_item.dart';
import 'package:shopping_cart/pages/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.shopping_bag, color: Colors.white),
          ),
        ],
      ),
      body: items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  CartItem item = items[index];
                  return ListTile(
                    leading: Image.network(item.product.imgUrl!, width: 50, height: 50),
            
                    title: Text(item.product.name),
                    subtitle: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (item.quantity > 1) {
                                item.quantity -= 1;
                              } else {
                                removeFromCart(item.product.id);
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
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '₹${item.subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              removeFromCart(item.product.id);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.black),
                        )
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
          : const Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Your cart is empty...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.shopping_cart, color: Colors.green, size: 40),
                ],
              ),
            ),
      bottomNavigationBar: items.isNotEmpty
          ? Container(
              color: Colors.green,
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price: ₹${getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
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
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Continue', style: TextStyle(color: Colors.white)),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
