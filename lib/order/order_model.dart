import 'package:hive/hive.dart';
import 'package:technaureus_application/products/product.dart';

@HiveType(typeId: 0)
class OrderModel {
  @HiveField(0)
  int customerId;

  @HiveField(1)
  double totalPrice;

  @HiveField(2)
  List<Product> products;

  OrderModel({
    required this.customerId,
    required this.totalPrice,
    required this.products,
  });
}
