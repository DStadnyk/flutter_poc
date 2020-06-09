class Product {
  int id;
  String gtin;
  String name;
  double quantity;
  bool checked;
  bool crossed;
  String categoryName;
  List<String> properties;

  Product(
      {this.id,
      this.gtin,
      this.name,
      this.quantity,
      this.checked,
      this.crossed,
      this.categoryName,
      this.properties});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        gtin: json['gtin'] as String,
        name: json['name'] as String,
        quantity: json['quantity'].toDouble(),
        checked: json['checked'] as bool,
        crossed: json['crossed'] as bool,
        categoryName: json['categoryName'] as String,
        properties: json['properies'] as List<String>);
  }

  toJson() {
    return {
      'gtin': gtin,
      'name': name,
      'quantity': quantity.toInt(),
      'checked': checked,
      'crossed': crossed,
      'categoryName': categoryName,
      'properties': properties,
    };
  }
}
