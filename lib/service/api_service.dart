import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manektech_assignment/model/product.dart';

class ApiService {
  Future<Product> fetchData() async {
    var url = Uri.parse(
        'http://205.134.254.135/~mobile/MtProject/public/api/product_list');

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Product data = Product.fromJson(json.decode(response.body));
      return data;
    } else {
      return Product();
    }
  }
}
