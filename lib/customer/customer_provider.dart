import 'package:flutter/material.dart';
import 'package:technaureus_application/customer/customer.dart';
import 'package:technaureus_application/customer/customer_repository.dart';

class CustomerProvider extends ChangeNotifier {
  List<Customer> _customers = [];
  BuildContext? _context;
  List<Customer> get customers => _customers;
  int _selectedCustomerId = 0;

  int get selectedCustomerId => _selectedCustomerId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCustomerSelected = false;

  Future<void> fetchCustomers() async {
    _isLoading = true;
    try {
      final repository = CustomerRepository();
      _customers = await repository.getCustomers();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      throw Exception("Failed to fetch products: $error");
    }
  }

  Future<void> addCustomer(Customer newCustomer, BuildContext context) async {
    _context = context;
    try {
      final repository = CustomerRepository();
      await repository.addCustomer(newCustomer);
      showSnackbar('Customer Added successfully');
      Navigator.pushReplacementNamed(_context!, '/customer');
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      showSnackbar('Failed to place order');
      Navigator.pushReplacementNamed(_context!, '/dashboard');
      throw Exception("Failed to fetch products: $error");
    }
  }

  void showSnackbar(String message) {
    if (_context != null) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool get isCustomerSelected => _isCustomerSelected;

  void selectCustomer(Customer customer) {
    _isCustomerSelected = true;
    _selectedCustomerId = customer.id;
    notifyListeners();
  }

  void unselectCustomer() {
    _isCustomerSelected = false;
    notifyListeners();
  }
}
