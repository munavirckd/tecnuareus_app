import 'package:hive/hive.dart';
import 'package:technaureus_application/order/order.dart';

class OfflineStorage {
  Future<void> saveOrder(Order order) async {
    final box = await Hive.openBox<Order>('orders');
    await box.add(order);
  }

  Future<List<Order>> getOrders() async {
    final box = await Hive.openBox<Order>('orders');
    return box.values.toList();
  }
}
