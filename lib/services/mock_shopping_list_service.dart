import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/model/shopping_list.dart';

class ShoppingListWS {
  static final apiUrl = "http://192.168.0.101:3000/shoppingLists/";
  static final mockApiUrl = "assets/mock/shopping_lists.json";

//  static Future<List<ShoppingList>> getShoppingLists() async {
//    final response = await http.get(apiUrl);
//
//    if (response.statusCode == 200) {
//      return compute(parseShoppingListsJson, response.body);
//    } else {
//      throw Exception('Failed to fetch Shopping Lists');
//    }
//  }

  static Future<List<ShoppingList>> getShoppingLists() async {
    var data = await rootBundle.loadString(mockApiUrl);
    return compute(parseShoppingListsJson, data);
  }

  static List<ShoppingList> parseShoppingListsJson(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed
        .map<ShoppingList>((json) => ShoppingList.fromJson(json))
        .toList();
  }
}
