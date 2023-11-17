import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/customer.dart';
import 'package:technaureus_application/customer/customer_provider.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _street2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Customer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _street1Controller,
                    decoration: InputDecoration(labelText: 'Street 1'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _street2Controller,
                    decoration: InputDecoration(labelText: 'Street 2'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Pincode'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color(0xFF005DAC),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final Customer newCustomer = Customer(
                  id: 0,
                  name: _nameController.text,
                  profilePic: "path/to/the/file/",
                  mobileNumber: _mobileController.text,
                  email: _emailController.text,
                  street: _street1Controller.text,
                  streetTwo: _street2Controller.text,
                  city: _cityController.text,
                  pincode: int.parse(_pincodeController.text),
                  state: 'kerala',
                  country: 'india',
                );
                await provider.addCustomer(newCustomer, context);
              },
              child: Text('Add Customer'),
            ),
          ]),
        ),
      ),
    );
  }
}
