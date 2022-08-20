import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:manektech_assignment/model/product.dart';
import 'package:manektech_assignment/provider/cart_provider.dart';
import 'package:manektech_assignment/service/api_service.dart';
import 'package:manektech_assignment/view/cart_screen.dart';
import 'package:manektech_assignment/widget/product_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ManekTech Assignment'),
          actions: [
            Consumer<CartProvider>(
              builder: (_, cartValue, ch) => Badge(
                badgeContent: Text(cartValue.itemCount.toString()),
                position: const BadgePosition(top: 2, end: 6),
                child: ch,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const CartScreen()),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: FutureBuilder<Product>(
            future: _apiService.fetchData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Data to show'),
                  );
                } else {
                  Product? data = snapshot.data;
                  return GridView.builder(
                      itemCount: data!.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ProductView(
                          title: data.data![index].title,
                          image: data.data![index].featuredImage,
                          onPressed: () {
                            provider.addItem(data.data![index]);
                          },
                        );
                      });
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
