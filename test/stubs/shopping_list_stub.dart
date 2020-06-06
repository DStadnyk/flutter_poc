import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/model/product.dart';

class ShoppingListStub {
  static ShoppingList getStub() {
    var _products = List<Product>();
    _products.add(
        Product(
            gtin: "3f82c350-aa46-44a6-a35b-d2db87759b5c",
            name: "Cookies - Englishbay Chochip",
            quantity: 24,
            checked: true,
            crossed: false,
            categoryName: "Industrial",
            properties: []
        ));

    _products.add(
        Product(
            gtin: "c4311ccd-0932-4ef0-ae61-7ec438803cf6",
            name: "Peppercorns - Pink",
            quantity: 7,
            checked: false,
            crossed: false,
            categoryName: "Industrial",
            properties: []
        ));

    _products.add(
        Product(
            gtin: "20e2312d-5e26-4373-ba47-cb6d7e4c48bf",
            name: "Longos - Burritos",
            quantity: 9,
            checked: false,
            crossed: false,
            categoryName: "Outdoors",
            properties: []
        ));

    return ShoppingList(
        title: "Computers",
        customerId: "mohed@hotmail.com",
        rows: _products
    );
  }
}