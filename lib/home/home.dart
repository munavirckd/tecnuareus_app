import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> gridItems = [
    {'title': 'Customers', 'icon': Icons.person, 'route': '/customer'},
    {'title': 'Products', 'icon': Icons.add_box_outlined, 'route': '/product'},
    {'title': 'New Order', 'icon': Icons.assignment, 'route': '/order'},
    {
      'title': 'Return Order',
      'icon': Icons.keyboard_return_outlined,
      'route': '/settings'
    },
    {
      'title': 'Add payment',
      'icon': Icons.payment_outlined,
      'route': '/settings'
    },
    {
      'title': 'Todays Order',
      'icon': Icons.calendar_today,
      'route': '/settings'
    },
    {
      'title': 'Today Summary',
      'icon': Icons.summarize_outlined,
      'route': '/settings'
    },
    {'title': 'Route', 'icon': Icons.route, 'route': '/settings'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.person_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: gridItems.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildGridItem(context, gridItems[index]);
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, item['route']);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'],
                size: 40.0,
                color: Color(0xFF005DAC),
              ),
              SizedBox(height: 8.0),
              Text(
                item['title'],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
