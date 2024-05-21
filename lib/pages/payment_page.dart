import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/orderview_page.dart';

enum PaymentOption {
  cashOnDelivery,
  paymentGateway,
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentOption? selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Mode of Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green[100],
      ),
      body: Container(
        height: 132,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Cash on Delivery'),
                trailing: Radio<PaymentOption>(
                  value: PaymentOption.cashOnDelivery,
                  groupValue: selectedPayment,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value;
                    });
                    _navigateToOrderView();
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedPayment = PaymentOption.cashOnDelivery;
                  });
                  _navigateToOrderView();
                },
                tileColor: selectedPayment == PaymentOption.cashOnDelivery ? Colors.green[50] : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: selectedPayment == PaymentOption.cashOnDelivery
                      ? const BorderSide(color: Colors.green)
                      : BorderSide.none,
                ),
              ),
              ListTile(
                title: const Text('Payment Gateway'),
                trailing: Radio<PaymentOption>(
                  value: PaymentOption.paymentGateway,
                  groupValue: selectedPayment,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value;
                    });
                    _navigateToOrderView();
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedPayment = PaymentOption.paymentGateway;
                  });
                  _navigateToOrderView();
                },
                tileColor: selectedPayment == PaymentOption.paymentGateway ? Colors.green[50] : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: selectedPayment == PaymentOption.paymentGateway
                      ? const BorderSide(color: Colors.green)
                      : BorderSide.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToOrderView() {
    if (selectedPayment != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderViewPage(selectedPaymentMode: selectedPayment!.index),
        ),
      );
    }
  }
}
