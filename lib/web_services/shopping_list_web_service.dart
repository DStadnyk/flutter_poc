import 'dart:convert';

import 'package:flutterapp/model/shopping_list.dart';
import 'package:http/http.dart' as http;

class ShoppingListWS {
  static final apiUrl = "http://192.168.0.101:3000/shoppingLists/";

  static Future<List<ShoppingList>> getShoppingLists() async {
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ShoppingList> result = [];
      for (Map i in data) {
        result.add(ShoppingList.fromJson(i));
      }
      return result;
    } else {
      throw Exception('Failed to fetch Shopping Lists');
    }
  }
}
