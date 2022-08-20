import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:manektech_assignment/database/db.dart';
import 'package:manektech_assignment/model/cart_item.dart';
import 'package:manektech_assignment/model/product.dart';
import 'package:manektech_assignment/service/api_service.dart';

class CartProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  int? quantity;
  bool isLoading = false;
  Map<String, CartItem> cartItem = {};
  List<CartItem> _cartProduct = [];
  List<CartItem> get cartProduct => _cartProduct;

  double get totalAmount {
    var total = 0.0;
    cartItem.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  int get itemCount {
    return cartItem.isEmpty ? 0 : cartItem.length;
  }

  void addItem(Data product) async {
    if (cartItem.containsKey(product.id)) {
      cartItem.update(
          product.id.toString(),
          (value) => CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                image: value.image,
                quantity: value.quantity + 1,
              ));
    } else {
      cartItem.putIfAbsent(
          product.id.toString(),
          () => CartItem(
                id: DateTime.now().toString(),
                title: product.title!,
                price: product.price!,
                quantity: 1,
                image: File(product.featuredImage!),
              ));
    }
    print("quantity :$quantity");
    notifyListeners();
    await DBHelper.insert(
      'user_products',
      {
        'id': product.id!,
        'title': product.title!,
        'price': product.price!,
        'quantity': quantity!,
        'image': product.featuredImage!,
      },
    );
  }

  Future<void> getDataFromDB() async {
    final dataList = await DBHelper.getData('user_products');
    _cartProduct = dataList
        .map(
          (e) => CartItem(
            id: e['id'],
            title: e['title'],
            price: e['price'],
            quantity: e['quantity'],
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
