import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/customer_list_screen.dart';
import 'package:technaureus_application/dahborad/custom_bottom_navigation_bar.dart';
import 'package:technaureus_application/dahborad/navigator_state.dart';
import 'package:technaureus_application/home/home.dart';
import 'package:technaureus_application/order/order_provider.dart';
import 'package:technaureus_application/products/cart_list.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    orderProvider.synchronizeWithServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AppNavigationState>(
        builder: (context, state, _) {
          return _getBody(context);
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _getBody(BuildContext context) {
    switch (context.read<AppNavigationState>().currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Center(child: Text('This is the Customer Page'));
      case 2:
        return CartList();
      case 3:
        return Center(child: Text('This is the Order Page'));
      case 4:
        return CustomerScreen();
      default:
        return Container();
    }
  }
}
