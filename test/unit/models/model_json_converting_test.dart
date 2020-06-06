import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/model/shopping_list.dart';
import '../../stubs/shopping_list_stub.dart';

void main() {
  test('Encode a product model to json string', () {
    var product = ShoppingListStub.getStub().rows.first;
    
    var jsonString = json.encode(product);
    
    expect(jsonString.runtimeType, String);
  });

  test('Encode a shopping list model to json string', () {
    var shoppingList = ShoppingListStub.getStub();
    
    var actual = json.encode(shoppingList);

    expect(actual.runtimeType, String);
  });

  test('Decode a json string to shopping list model', () {
    var jsonString =  '{"id": 1,"title": "Computers","customerId": "Julianna.Ellesworth@gmail.com",' +
    '"rows": [{"id": 1,"gtin": "3f82c350-aa46-44a6-a35b-d2db87759b5c","name": "Cookies - Englishbay' +
    'Chochip","quantity": 24,"checked": true,"crossed": false,"categoryName": "Industrial","propert' +
    'ies": [{}]}]}';

    var map = json.decode(jsonString);
    var actual = ShoppingList.fromJson(map);
    
    expect(actual.id, 1); 
  });
}
