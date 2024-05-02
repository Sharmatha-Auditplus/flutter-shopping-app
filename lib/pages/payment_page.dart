import 'package:flutter/material.dart';

import 'package:shopping_cart/pages/orderview_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedPayment = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Mode of Payment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          Card(
            margin: const EdgeInsets.all(40),
            child: RadioListTile(
              title: const Text('Pay on Delivery'),
              value: 0,
              groupValue: selectedPayment,
              onChanged: (int? value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(40),
            child: RadioListTile(
              title: const Text('Online Payment'),
              value: 1,
              groupValue: selectedPayment,
              onChanged: (int? value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderViewPage(selectedPaymentMode: selectedPayment),
                      ),
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
      ),
    );
  }
}
