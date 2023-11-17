import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final int price;

  @HiveField(4)
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'quantity': quantity,
      'price': price,
    };
  }
}
