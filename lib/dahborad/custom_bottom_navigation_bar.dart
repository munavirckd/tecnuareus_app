import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/dahborad/navigator_state.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: context.watch<AppNavigationState>().currentIndex,
      onTap: (index) {
        context.read<AppNavigationState>().updateIndex(index);
        if (index == 0) {
          Navigator.pushNamed(context, '/dashboard');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/cart');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/customer');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          label: 'New Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.keyboard_return_rounded),
          label: 'Return Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded),
          label: 'Customers',
        ),
      ],
    );
  }
}
