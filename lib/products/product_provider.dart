import 'package:flutter/material.dart';
import 'package:technaureus_application/products/product.dart';
import 'package:technaureus_application/products/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _cartList = [];

  List<Product> get cartList => _cartList;

  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    try {
      final repository = ProductRepository();
      _products = await repository.getProducts();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      throw Exception("Failed to fetch products: $error");
    }
  }

  void addtoCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }

  List<Product> getCartList() {
    return _cartList.toList();
  }

  void incrementQuantity(Product cartItem) {
    final index = _cartList.indexOf(cartItem);
    if (index != -1) {
      _cartList[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(Product cartItem) {
    final index = _cartList.indexOf(cartItem);
    if (index != -1 && cartItem.quantity > 1) {
      _cartList[index].quantity--;
      notifyListeners();
    }
  }

  void deleteFromCart(Product cartItem) {
    final index = _cartList.indexOf(cartItem);
    if (index != -1) {
      _cartList.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }

  int getSubtotal() {
    return _cartList.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double getTaxRate() {
    return 0;
  }

  double calculateTax() {
    return getSubtotal() * getTaxRate();
  }

  double calculateTotal() {
    return getSubtotal() + calculateTax();
  }
}
