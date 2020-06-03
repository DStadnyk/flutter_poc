import 'package:flutterapp/services/provider_service.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutterapp/model/shopping_list.dart';

class ShoppingListService {
  static final enpointUrl = "https://shoppinglist.mcpe.se/api/v1/shoppinglist";

  ProviderService _providerService;

  ShoppingListService(this._providerService);

  Future<List<ShoppingList>> getDataAsync(String customerId) async {
    return await _providerService
        .getAsync(enpointUrl + "?customerid=" + customerId)
        .then((response) => _parseShoppingListsJson(response.body)
          .where((list) => list.customerId == customerId)
          .toList());
  }

//  if (response.statusCode == 200) {
//    return compute(parseShoppingListsJson, response.body);
//  } else {
//    throw Exception('Failed to fetch Shopping Lists');
//  }

// static Future<List<ShoppingList>> getShoppingLists() async {
//   var data = await rootBundle.loadString(mockApiUrl);
//   return compute(parseShoppingListsJson, data);
// }

  List<ShoppingList> _parseShoppingListsJson(String responseBody) {
    return json
        .decode(responseBody)
        .map<ShoppingList>((json) => ShoppingList.fromJson(json))
        .toList();
  }
}