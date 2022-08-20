import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final String? title;
  final String? image;
  final Function()? onPressed;

  const ProductView({
    Key? key,
    required this.title,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.network(
                image ?? "",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      title ?? '',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: onPressed, icon: const Icon(Icons.shopping_cart))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
