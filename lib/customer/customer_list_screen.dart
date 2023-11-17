import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/add_customer_screen.dart';
import 'package:technaureus_application/customer/customer_provider.dart';
import 'package:technaureus_application/dahborad/custom_bottom_navigation_bar.dart';
import 'package:technaureus_application/products/cart_list.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    final provider = Provider.of<CustomerProvider>(context, listen: false);
    provider.fetchCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Customers",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: provider.customers.length,
                itemBuilder: (context, index) {
                  final customer = provider.customers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Provider.of<CustomerProvider>(context, listen: false)
                            .selectCustomer(customer);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartList()),
                        );
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 60,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customer.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(customer.street),
                                    Text(
                                        '${customer.city}, ${customer.city}, ${customer.state}, ${customer.pincode}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCustomerDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
