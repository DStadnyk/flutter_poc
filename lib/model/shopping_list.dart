import 'package:flutterapp/model/product.dart';

class ShoppingList {
  int id;
  String title;
  String customerId;
  List<Product> rows;

  ShoppingList({this.id, this.title, this.customerId, this.rows});

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    var shoppingList = ShoppingList(
        id: json["id"] as int,
        title: json["title"] as String,
        customerId: json["customerId"] as String);

    if (json['rows'] != null) {
      shoppingList.rows = (json['rows'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    }

    return shoppingList;
  }

  toJson() {
    return {
      'title': title,
      'customerId': customerId,
      'rows': rows,
    };
  }

  getCheckedAmount() {
    return this.rows.where((element) => element.checked == true).length;
  }

  getCrossedAmount() {
    return this.rows.where((element) => element.crossed == true).length;
  }
}
