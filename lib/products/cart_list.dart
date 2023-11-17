import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/customer_list_screen.dart';
import 'package:technaureus_application/customer/customer_provider.dart';
import 'package:technaureus_application/dahborad/custom_bottom_navigation_bar.dart';
import 'package:technaureus_application/order/order_provider.dart';
import 'product_provider.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  bool _isCustomerSelected = false;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    _isCustomerSelected =
        Provider.of<CustomerProvider>(context).isCustomerSelected;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: _buildBody(context),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return ListView.separated(
                  itemCount: productProvider.cartList.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    );
                  },
                  itemBuilder: (context, index) {
                    final cartItem = productProvider.cartList[index];
                    return ListTile(
                      title: Text(cartItem.name),
                      subtitle: Text('\$${cartItem.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: Color(0xFF005DAC),
                              borderRadius: BorderRadius.circular(
                                  12), // Set the border radius
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    productProvider.decrementQuantity(cartItem);
                                  },
                                ),
                                Text(
                                  cartItem.quantity.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    productProvider.incrementQuantity(cartItem);
                                  },
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              productProvider.deleteFromCart(cartItem);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black,
                width: .5,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal:'),
                              Text(
                                  '\$${productProvider.getSubtotal().toStringAsFixed(2)}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax:'),
                              Text(
                                  '\$${productProvider.calculateTax().toStringAsFixed(2)}'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '\$${productProvider.calculateTotal().toStringAsFixed(2)}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color(0xFF005DAC),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final orderProvider = Provider.of<OrderProvider>(
                              context,
                              listen: false);
                          _isCustomerSelected
                              ? orderProvider.createOrder(context)
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerScreen()),
                                );
                        },
                        child: Text('Order'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color(0xFF005DAC),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final orderProvider = Provider.of<OrderProvider>(
                              context,
                              listen: false);
                          orderProvider.createOrder(context);
                        },
                        child: Text('Order & Deliver'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
