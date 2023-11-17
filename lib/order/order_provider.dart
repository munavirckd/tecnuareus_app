import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/customer_provider.dart';
import 'package:technaureus_application/order/offline_storage.dart';
import 'package:technaureus_application/order/order.dart';
import 'package:technaureus_application/order/order_repository.dart';
import 'package:technaureus_application/products/product_provider.dart';

class OrderProvider with ChangeNotifier {
  Order? _currentOrder;
  BuildContext? _context;
  final OfflineStorage _offlineStorage = OfflineStorage();
  late ProductProvider productProvider;

  Order? get currentOrder => _currentOrder;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> isOnline() async {
    try {
      final response = await Dio().get('https://www.google.com');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> createOrder(BuildContext context) async {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    _context = context;
    _isLoading = true;
    final customerId = Provider.of<CustomerProvider>(context, listen: false)
        .selectedCustomerId;
    int totalPrice =
        Provider.of<ProductProvider>(context, listen: false).getSubtotal();

    final Order order = Order(
      customerId: customerId,
      totalPrice: totalPrice,
      products: Provider.of<ProductProvider>(context, listen: false).cartList,
    );

    bool onlineStatus = await isOnline();
    if (onlineStatus) {
      await sendOrderToServer(order);
    } else {
      await _offlineStorage.saveOrder(order);
      showSnackbar('Order placed successfully');
      Navigator.pushReplacementNamed(_context!, '/dashboard');
    }
  }

  Future<void> sendOrderToServer(Order order) async {
    try {
      final repository = OrderRepository();
      await repository.addOrder(order);
      showSnackbar('Order placed successfully');
      removeOrder(order);
      productProvider.clearCart();
      Navigator.pushReplacementNamed(_context!, '/dashboard');
      _isLoading = false;
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

  Future<void> removeOrder(Order order) async {
    final box = await Hive.openBox<Order>('orders');
    final index =
        box.values.toList().indexWhere((o) => o.customerId == order.customerId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> synchronizeWithServer() async {
    bool onlineStatus = await isOnline();
    if (onlineStatus) {
      final List<Order> localOrders = await _offlineStorage.getOrders();

      for (final order in localOrders) {
        await sendOrderToServer(order);
        print("successs");
      }
    }
  }
}
