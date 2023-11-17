import 'package:technaureus_application/network_service.dart';
import 'package:technaureus_application/products/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    try {
      final response =
          await NetworkService().get('http://62.72.44.247/api/products/');
      final List<Product> products = (response.data['data'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
      return products;
    } catch (error) {
      throw Exception("Failed to load products: $error");
    }
  }
}
