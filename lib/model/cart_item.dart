import 'dart:io';

class CartItem {
  String id;
  String title;
  int price;
  int quantity;
  File image;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        image: json['image'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "image": image,
      };
}
