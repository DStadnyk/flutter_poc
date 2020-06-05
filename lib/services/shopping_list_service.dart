import 'dart:io';
import 'package:flutterapp/services/provider_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutterapp/model/shopping_list.dart';

class ShoppingListService {
  static final _endPointUrl =
      "https://shoppinglist.mcpe.se/api/v1/shoppinglist";

  ProviderService _providerService;
  ShoppingListService(this._providerService);

  Future<List<ShoppingList>> getShoppingListsAsync(String customerId) async {
    return await _providerService
        .getAsync(_endPointUrl + "?customerid=" + customerId)
        .then((response) => _parseShoppingListsJson(response.body));
  }

  List<ShoppingList> _parseShoppingListsJson(String responseBody) {
    return json
        .decode(responseBody)
        .map<ShoppingList>((json) => ShoppingList.fromJson(json))
        .toList();
  }

  Future<ShoppingList> createShoppingListAsync(String id, String s) async {
    var shoppingList = ShoppingList(customerId: id, title: s);

    return await _providerService
        .postAsync(_endPointUrl, shoppingList)
        .then((response) => json.decode(response.body))
        .then((map) => ShoppingList.fromJson(map));
  }

  Future<bool> deleteShoppingListAsync(int id) async {
    var response = await _providerService.deleteAsync("$_endPointUrl/$id");

    return (response.statusCode == HttpStatus.ok) ? true : false;
  }
}
