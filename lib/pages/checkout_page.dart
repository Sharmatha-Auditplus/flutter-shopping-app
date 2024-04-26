import 'package:flutter/material.dart';
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
  DeliveryMethod? delivery = DeliveryMethod.pickup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? country;
  String? state;
  String? fullName;
  String? mobNumber;
  String? pincode;
  String? address;
  String? area;
  String? city;
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Radio<DeliveryMethod>(
                      value: DeliveryMethod.pickup,
                      groupValue: delivery,
                      onChanged: (DeliveryMethod? value) {
                        setState(() {
                          delivery = value;
                          if (value == DeliveryMethod.pickup) {
                            _resetForm();
                          } else {
                            _textColor = Colors.black;
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
                          delivery = value;
                          if (value == DeliveryMethod.homeDelivery) {
                            _textColor = Colors.black;
                            _showAddressForm();
                          } else {
                            _resetForm();
                          }
                        });
                      },
                    ),
                    const Text('Home Delivery'),
                  ],
                ),
              ),
            ),
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
            if (addresses.isNotEmpty && delivery == DeliveryMethod.homeDelivery) ...[
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
                          Text(
                            addresses[index]['country']!,
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
                  (delivery == DeliveryMethod.homeDelivery && _isAddressFormFilled()))
                TextButton(
                  onPressed: () {
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

  void _showAddressForm() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fill Delivery Address:',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    DropdownButtonFormField(
                      value: country,
                      items: const [
                        DropdownMenuItem(value: 'India', child: Text('India')),
                        DropdownMenuItem(value: 'Japan', child: Text('Japan')),
                        DropdownMenuItem(value: 'China', child: Text('China')),
                        DropdownMenuItem(value: 'France', child: Text('France')),
                        DropdownMenuItem(value: 'Ireland', child: Text('Ireland')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          country = newValue;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Country'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a country';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) => fullName = value,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) => mobNumber = value,
                      decoration: const InputDecoration(labelText: 'Mob Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length != 10) {
                          return 'Mobile number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) {
                        pincode = value;
                      },
                      decoration: const InputDecoration(labelText: 'Pincode'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a pincode';
                        }
                        if (value.length != 6) {
                          return 'Pincode must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) => address = value,
                      decoration: const InputDecoration(labelText: 'Flat,House.no,Company,Apartment'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) => area = value,
                      decoration: const InputDecoration(labelText: 'Area,Street,Sector'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your area';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Landmark'),
                    ),
                    TextFormField(
                      onChanged: (value) => city = value,
                      decoration: const InputDecoration(labelText: 'Town,City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: state,
                      items: const [
                        DropdownMenuItem(value: 'TamilNadu', child: Text('TamilNadu')),
                        DropdownMenuItem(value: 'Kerala', child: Text('Kerala')),
                        DropdownMenuItem(value: 'Karnataka', child: Text('Karnataka')),
                        DropdownMenuItem(value: 'Punjab', child: Text('Punjab')),
                        DropdownMenuItem(value: 'Gujarat', child: Text('Gujarat')),
                        DropdownMenuItem(value: 'Madhya Pradesh', child: Text('Madhya Pradesh')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          state = newValue;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a state';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addresses.add({
                              'country': country,
                              'state': state,
                              'fullName': fullName,
                              'mobNumber': mobNumber,
                              'pincode': pincode,
                              'address': address,
                              'area': area,
                              'city': city,
                            });
                            setState(() {
                              selectedAddressIndex = addresses.length - 1;
                              _resetForm();
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Use this Address'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isAddressFormFilled() {
    return country != null &&
        state != null &&
        fullName != null &&
        mobNumber != null &&
        pincode != null &&
        address != null &&
        area != null &&
        city != null;
  }

  void _resetForm() {
    setState(() {
      country = null;
      state = null;
      fullName = null;
      mobNumber = null;
      pincode = null;
      address = null;
      area = null;
      city = null;
      _formKey.currentState?.reset();
    });
  }
}
