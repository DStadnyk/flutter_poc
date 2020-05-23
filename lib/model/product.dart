class Product {
  int id;
  String gtin;
  String name;
  int quantity;
  bool checked;
  bool crossed;
  String categoryName;

  Product(
      {this.id,
      this.gtin,
      this.name,
      this.quantity,
      this.checked,
      this.crossed,
      this.categoryName});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        gtin: json['gtin'] as String,
        name: json['name'] as String,
        quantity: json['quantity'] as int,
        checked: json['checked'] as bool,
        crossed: json['crossed'] as bool,
        categoryName: json['categoryName'] as String);
  }
}
