import 'package:flutter/material.dart';

import 'package:shopping_cart/model/cart.dart';
//import 'package:shopping_cart/model/cart_items.dart';

import 'package:shopping_cart/pages/home_page.dart';

class OrderViewPage extends StatelessWidget {
  // final String orderId;
  // final String deliveryAddress;
  //final List<CartItem> purchasedItems=items.toList();
  const OrderViewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    items.clear();
    //final List<CartItem> purchasedItems = items.toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Confirm Your Order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Order Placed Successfully...',
              style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            //Text('Order ID: $orderId',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            //const SizedBox(height: 16),
            //const Text('Delivery Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            //Text(deliveryAddress, style: const TextStyle(fontSize: 16)),
            // const SizedBox(height: 16),
            // const Text('Purchased Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: purchasedItems.length,
            //   itemBuilder: (context, index) {
            //     CartItem item = purchasedItems[index];
            //     return ListTile(
            //       title: Text(item.product.name),
            //       subtitle: Text('Quantity: ${item.quantity}'),
            //       trailing: Text('₹${item.subtotal.toStringAsFixed(2)}'),
            //     );
            //   },
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => true,
                );
              },
              child: const Text('Back To Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
