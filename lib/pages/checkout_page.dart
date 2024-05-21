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
  DeliveryMethod? delivery;
  int selectedAddressIndex = -1;
  List<Map<String, String?>> addresses = [];
  bool _isHovering = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    print(delivery);
    print(selectedAddressIndex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50]!,
        leading: const BackButton(color: Colors.black),
        title: const Text('Mode of Delivery',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text('Store Pickup'),
                      ],
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    trailing: Radio<DeliveryMethod>(
                      value: DeliveryMethod.pickup,
                      groupValue: delivery,
                      activeColor: Colors.green,
                      onChanged: (DeliveryMethod? value) {
                        setState(() {
                          delivery = value;
                          selectedAddressIndex = -1;
                        });
                        _navigateToPaymentPage(null);
                      },
                    ),
                    onTap: () {
                      setState(() {
                        delivery = DeliveryMethod.pickup;
                        selectedAddressIndex = -1;
                      });
                      _navigateToPaymentPage(null);
                    },
                    tileColor: delivery == DeliveryMethod.pickup ? Colors.green[50] : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: delivery == DeliveryMethod.pickup
                          ? const BorderSide(color: Colors.green)
                          : const BorderSide(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.green[50]!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Deliver to:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _isTapped = true),
                      onTapUp: (_) {
                        setState(() {
                          _isTapped = false;
                        });
                        _showAddressForm();
                      },
                      onTapCancel: () => setState(() {
                        _isTapped = false;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: _isHovering || _isTapped
                            ? Matrix4.translationValues(0, -2, 0)
                            : Matrix4.translationValues(0, 0, 0),
                        child: Text(
                          '+ Add New Address',
                          style: TextStyle(
                            color: _isHovering || _isTapped ? Colors.red : Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 10,
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedAddressIndex = index;
                        delivery = null;
                      });
                      _navigateToPaymentPage(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        //color: selectedAddressIndex == index ? Colors.green[50] : Colors.white,
                        border: Border.all(color: selectedAddressIndex == index ? Colors.green : Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addresses[index]['fullName']!,
                                    style: const TextStyle(
                                        color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                                  ),
                                  Text(
                                    '${addresses[index]['address']}, ${addresses[index]['area']}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                                  ),
                                  Text(
                                    '${addresses[index]['city']},${addresses[index]['state']},${addresses[index]['pincode']}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                                  ),
                                  const Text(
                                    'INDIA',
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                                  ),
                                  Text(
                                    'Phone number:${addresses[index]['mobNumber']!}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Radio<DeliveryMethod>(
                              value: DeliveryMethod.homeDelivery,
                              groupValue: delivery,
                              activeColor: Colors.green,
                              onChanged: (DeliveryMethod? value) {
                                setState(() {
                                  delivery = value;
                                  selectedAddressIndex = index;
                                });
                                _navigateToPaymentPage(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
        // _navigateToPaymentPage(addresses.length - 1);
      }
    });
  }

  void _navigateToPaymentPage(int? selectedIndex) {
    if (selectedIndex != null) {
      selectedAddressIndex = selectedIndex;
      OrderSummary.deliveryMethod = DeliveryMethod.homeDelivery;
    } else {
      OrderSummary.deliveryMethod = DeliveryMethod.pickup;
    }
    if (OrderSummary.deliveryMethod == DeliveryMethod.pickup || selectedAddressIndex != -1) {
      OrderSummary.deliveryMethod = delivery ?? DeliveryMethod.pickup;
      if (selectedAddressIndex > -1) {
        OrderSummary.deliveryAddress = addresses[selectedAddressIndex];
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentPage()),
      );
    }
  }
}
