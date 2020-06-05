import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/services/provider_service.dart';
import 'dart:convert';
import '../../stubs/shopping_list_stub.dart';

void main() {
  ProviderService _sut;

  setUp(() {
    _sut = ProviderService();
  });

  test('Create the sut', () {
    expect(_sut, isNotNull);
  });

  test('Get data from a rest service', () async {
    var url =
        "https://shoppinglist.mcpe.se/api/v1/shoppinglist?customerid=mohed@hotmail.com";

    var actual = await _sut.getAsync(url);

    expect(actual, isNotNull);
  });

  test('Get 186 as customer id for user mohed@hotmail.com', () async {
    var url =
        "https://shoppinglist.mcpe.se/api/v1/shoppinglist?customerid=mohed@hotmail.com";

    var response = await _sut
        .getAsync(url)
        .then((response) => jsonDecode(response.body))
        .then((list) => list.first)
        .then((map) => ShoppingList.fromJson(map));

    var actual = response.id;

    expect(actual, 186);
  });

  test('Create a shopping list for user mohed@hotmail.com ', () async {
    var url = "https://shoppinglist.mcpe.se/api/v1/shoppinglist";
    var shoppingList = ShoppingListStub.getStub();

    var actual = await _sut.postAsync(url, shoppingList);

    expect(actual.statusCode, HttpStatus.ok);
  });

  test('Delete a created shopping list for user mohed@hotmail.com', () async {
    var url = "https://shoppinglist.mcpe.se/api/v1/shoppinglist";
    var shoppingList = ShoppingListStub.getStub();
    var map = await _sut.postAsync(url, shoppingList)
    .then((response) => response.body)
    .then((jsonString) => json.decode(jsonString));

    var actual = await _sut.deleteAsync("$url/${map['id']}");

    expect(actual.statusCode, HttpStatus.ok);
  });
}
