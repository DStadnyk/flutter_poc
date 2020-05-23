import 'package:flutterapp/model/product.dart';

class ShoppingList {
  int id;
  String title;
  String customerId;
  String dateCreated;
  List<Product> rows;

  ShoppingList(
      {this.id, this.title, this.customerId, this.dateCreated, this.rows});

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      id: json["id"] as int,
      title: json["title"] as String,
      customerId: json["customerId"] as String,
      dateCreated: json["dateCreated"] as String,
      rows: (json['rows'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }

  getCheckedAmount() {
    return this.rows.where((element) => element.checked == true).length;
  }

  getCrossedAmount() {
    return this.rows.where((element) => element.crossed == true).length;
  }
}
