import 'package:flutter/material.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? state;
  String? fullName;
  String? mobNumber;
  String? pincode;
  String? address;
  String? area;
  String? city;

  @override
  Widget build(BuildContext context) {
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
                        final data = {
                          'state': state,
                          'fullName': fullName,
                          'mobNumber': mobNumber,
                          'pincode': pincode,
                          'address': address,
                          'area': area,
                          'city': city,
                        };
                        _resetForm();
                        Navigator.pop(context, data);
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
  }

  bool _isAddressFormFilled() {
    return state != null &&
        fullName != null &&
        mobNumber != null &&
        pincode != null &&
        address != null &&
        area != null &&
        city != null;
  }

  void _resetForm() {
    setState(() {
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
