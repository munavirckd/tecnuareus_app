import 'package:hive/hive.dart';
import 'package:technaureus_application/products/product.dart';
part 'order.g.dart';

@HiveType(typeId: 0)
class Order {
  @HiveField(0)
  int customerId;

  @HiveField(1)
  int totalPrice;

  @HiveField(2)
  List<Product> products;

  Order({
    required this.customerId,
    required this.totalPrice,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'total_price': totalPrice,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
