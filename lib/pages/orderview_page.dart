
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/order_summary.dart';
import 'package:shopping_cart/pages/checkout_page.dart';
import 'package:shopping_cart/pages/home_page.dart';

class OrderViewPage extends StatefulWidget {
  const OrderViewPage({super.key, required this.selectedPaymentMode});
  final int selectedPaymentMode;

  @override
  // ignore: library_private_types_in_public_api
  _OrderViewPageState createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handleResult(Map<String, dynamic> response) {
    if (response.containsKey('razorpay_payment_id')) {
      _handlePaymentSuccess(PaymentSuccessResponse.fromMap(response));
    } else if (response.containsKey('error')) {
      var error = response['error'];
      if (error is Map<String, dynamic>) {
        _handlePaymentError(PaymentFailureResponse.fromMap(error));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error format: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected response: $response')),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    clearCart();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet selected: ${response.walletName}')),
    );
  }

  void _openRazorpayCheckout() {
    var desc = items.map((item) => item.product.name ?? "Grocery Item").join(" ");
    var options = {
      'key': 'rzp_test_m8LKhdMDB6WHVj',
      'amount': 50000,
      'name': 'Shopping App',
      'description': desc,
      'timeout': 120,
      'currency': 'INR',
      'prefill': {'email': 'test@example.com', 'contact': '8072817168'},
      'order_id': 'order_OD7MPEtPGJnJY6',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Place your order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
            Container(
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Items:',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                        Text('₹${getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery:',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                        Text('₹0.00', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Order Total:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                          Text('₹${formatCurrency(getTotalPrice())}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 217, 14, 14))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payment Mode:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                    //const SizedBox(width: 30),
                    Text(getPaymentModeText(widget.selectedPaymentMode),
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getOrderDeliveryText(),
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        if (OrderSummary.deliveryAddress != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(OrderSummary.deliveryAddress?['fullName'] ?? '',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text(
                                '${OrderSummary.deliveryAddress?['address'] ?? ''}, ${OrderSummary.deliveryAddress?['area'] ?? ''}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${OrderSummary.deliveryAddress?['city'] ?? ''}, ${OrderSummary.deliveryAddress?['state'] ?? ''}, ${OrderSummary.deliveryAddress?['pincode'] ?? ''}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                'INDIA',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text('Mobile Number: ${OrderSummary.deliveryAddress?['mobNumber'] ?? ''}',
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
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextButton(
                  // onPressed: () {
                  //   clearCart();
                  //   Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const HomePage()),
                  //     (route) => true,
                  //   );
                  // },
                  onPressed: _openRazorpayCheckout,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.green[100]!),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text(
                    'Place Your Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPaymentModeText(int selectedPaymentMode) {
    return selectedPaymentMode == 0 ? 'Cash on Delivery' : 'Payment Gateway';
  }

  String getOrderDeliveryText() {
    if (OrderSummary.deliveryMethod == DeliveryMethod.pickup) {
      return 'Pickup on Store';
    } else if (OrderSummary.deliveryMethod == DeliveryMethod.homeDelivery && OrderSummary.deliveryAddress != null) {
      return 'Deliver to:';
    } else {
      return '';
    }
  }

  void clearCart() {
    items.clear();
  }
}
