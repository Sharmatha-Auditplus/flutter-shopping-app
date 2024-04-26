import 'package:flutter/material.dart';
import 'package:shopping_cart/model/order_summary.dart';
import 'package:shopping_cart/pages/address_form.dart';
import 'package:shopping_cart/pages/payment_page.dart';

enum DeliveryMethod {
  pickup,
  homeDelivery,
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DeliveryMethod delivery = DeliveryMethod.pickup;

  int selectedAddressIndex = -1;
  Color _textColor = Colors.green;

  List<Map<String, String?>> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Mode of Delivery',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.green,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildModeSelection(),
            const SizedBox(height: 10),
            if (delivery == DeliveryMethod.pickup)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Finding nearby pickup locations...'),
                    ),
                  );
                },
                child: const Text(
                  'Find a pickup location near you',
                  style: TextStyle(color: Colors.green, decoration: TextDecoration.underline),
                ),
              ),
            if (delivery == DeliveryMethod.homeDelivery) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _textColor = Colors.black;
                      _showAddressForm();
                    });
                  },
                  //hoverColor: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Add New Address',
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: delivery == DeliveryMethod.homeDelivery ? TextDecoration.underline : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: index,
                      groupValue: selectedAddressIndex,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAddressIndex = value!;
                        });
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addresses[index]['fullName']!,
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                          Text(
                            '${addresses[index]['address']}, ${addresses[index]['area']}',
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                          Text(
                            '${addresses[index]['city']},${addresses[index]['state']},${addresses[index]['pincode']}',
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                          const Text(
                            'INDIA',
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                          Text(
                            'Phone number:${addresses[index]['mobNumber']!}',
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              const Spacer(),
              if (delivery == DeliveryMethod.pickup ||
                  (delivery == DeliveryMethod.homeDelivery && selectedAddressIndex != -1))
                TextButton(
                  onPressed: () {
                    globalOrderSummary.deliveryMethod = delivery;
                    globalOrderSummary.deliveryAddress = addresses[selectedAddressIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentPage()),
                    ).then((_) => setState(() {}));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Continue', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Radio<DeliveryMethod>(
              value: DeliveryMethod.pickup,
              groupValue: delivery,
              onChanged: (DeliveryMethod? value) {
                setState(() {
                  if (value != null) {
                    delivery = value;
                  }
                });
              },
            ),
            const Text('Store Pickup'),
            const SizedBox(width: 20),
            Radio<DeliveryMethod>(
              value: DeliveryMethod.homeDelivery,
              groupValue: delivery,
              onChanged: (DeliveryMethod? value) {
                setState(() {
                  if (value != null) {
                    delivery = value;
                  }
                });
              },
            ),
            const Text('Home Delivery'),
          ],
        ),
      ),
    );
  }

  void _showAddressForm() {
    showModalBottomSheet<Map<String, String?>>(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const AddressForm();
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          addresses.add(value);
          selectedAddressIndex = addresses.length - 1;
        });
      }
    });
  }
}
