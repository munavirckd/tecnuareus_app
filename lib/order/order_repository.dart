import 'package:technaureus_application/network_service.dart';
import 'package:technaureus_application/order/order.dart';

class OrderRepository {
  Future<void> addOrder(Order order) async {
    try {
      final response = await NetworkService()
          .post('http://62.72.44.247/api/orders/', order.toJson());

      if (response.statusCode == 200) {
        print('Order added successfully.');
      } else {
        print('Failed to add order. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding order: $error');
    }
  }
}
