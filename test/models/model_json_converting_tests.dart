import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../services/shopping_list_stub.dart';

void main() {
  test('Converting a product model to json string', () {
    var product = ShoppingListStub.getStub().rows.first;
    var jsonString = json.encode(product);
    print(jsonString);
    
    expect(jsonString.runtimeType, String);
  });

  test('Converting a shopping list model to json string', () {
    var shoppingList = ShoppingListStub.getStub();
    var actual = json.encode(shoppingList);
    print(actual);

    expect(actual.runtimeType, String);
  });
}
