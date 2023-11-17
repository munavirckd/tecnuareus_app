import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_application/customer/customer_list_screen.dart';
import 'package:technaureus_application/customer/customer_provider.dart';
import 'package:technaureus_application/dahborad/custom_bottom_navigation_bar.dart';
import 'package:technaureus_application/dahborad/navigator_state.dart';
import 'package:technaureus_application/products/cart_list.dart';
import 'package:technaureus_application/products/product.dart';
import 'package:technaureus_application/products/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isCustomerSelected = false;

  @override
  void initState() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isCustomerSelected =
        Provider.of<CustomerProvider>(context).isCustomerSelected;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Nesto Hyper Market",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              if (_isCustomerSelected) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartList()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: provider.products.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildProductItem(context, provider.products[index]);
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final isAddedToCart =
        Provider.of<ProductProvider>(context).cartList.contains(product);

    final imageUrl = 'http://62.72.44.247${product.image}';
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 80, width: 80, fit: BoxFit.fill),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
                !isAddedToCart
                    ? Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Color(0xFF005DAC),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              provider.addtoCart(product);
                            },
                            child: Text("Add"),
                          ),
                        ),
                      )
                    : QuantitControllButton(product)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget QuantitControllButton(Product product) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      height: 28,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFF005DAC),
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                provider.decrementQuantity(product);
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: Text(
              product.quantity.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          InkWell(
              onTap: () {
                provider.incrementQuantity(product);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }
}
