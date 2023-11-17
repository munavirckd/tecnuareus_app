import 'package:technaureus_application/customer/customer.dart';
import 'package:technaureus_application/network_service.dart';

class CustomerRepository {
  Future<List<Customer>> getCustomers() async {
    try {
      final response =
          await NetworkService().get('http://62.72.44.247/api/customers/');
      final List<Customer> customers = (response.data['data'] as List)
          .map((json) => Customer.fromJson(json))
          .toList();
      return customers;
    } catch (error) {
      throw Exception("Failed to load products: $error");
    }
  }

  Future<void> addCustomer(Customer customer) async {
    print(customer.toJson());
    try {
      final response = await NetworkService()
          .post('http://62.72.44.247/api/customers/', customer.toJson());
      if (response.statusCode == 200) {
        print('Customer added successfully.');
      } else {
        print('Failed to add customer. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding customer: $error');
    }
  }
}
