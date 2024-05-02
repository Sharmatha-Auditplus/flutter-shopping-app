import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/order_summary.dart';
import 'package:shopping_cart/pages/checkout_page.dart';
import 'package:shopping_cart/pages/home_page.dart';

class OrderViewPage extends StatelessWidget {
  const OrderViewPage({super.key, required this.selectedPaymentMode});
  final int selectedPaymentMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Place your order',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Items:',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black)),
                        Text('₹${getTotalPrice().toStringAsFixed(2)}'),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery:',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black)),
                        Text('₹0.00'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Total:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        Text('₹${getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 217, 14, 14))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payment Mode:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    //const SizedBox(width: 30),
                    Text(getPaymentModeText(selectedPaymentMode),
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            globalOrderSummary.deliveryMethod == DeliveryMethod.pickup
                                ? 'Pickup on Store'
                                : 'Deliver to:',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        if (globalOrderSummary.deliveryMethod == DeliveryMethod.homeDelivery)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(globalOrderSummary.deliveryAddress?['fullName'] ?? '',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text(
                                '${globalOrderSummary.deliveryAddress?['address'] ?? ''}, ${globalOrderSummary.deliveryAddress?['area'] ?? ''}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${globalOrderSummary.deliveryAddress?['city'] ?? ''}, ${globalOrderSummary.deliveryAddress?['state'] ?? ''}, ${globalOrderSummary.deliveryAddress?['pincode'] ?? ''}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                'INDIA',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text('Mobile Number: ${globalOrderSummary.deliveryAddress?['mobNumber'] ?? ''}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  clearCart();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => true,
                  );
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
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPaymentModeText(int selectedPaymentMode) {
    return selectedPaymentMode == 0 ? 'Pay on Delivery' : 'Online Payment';
  }

  void clearCart() {
    items.clear();
  }
}
