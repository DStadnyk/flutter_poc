class Product {
  int id;
  String image;
  double price;
  String title;
  String description;
  Product(this.id, this.image, this.price, this.description, this.title);
}

final List<Product> products = [
  new Product(425, "assets/images/fiji.jpg", 0.95,
      "From the islands of Fiji to you", "Fiji 0.5l"),
  new Product(321, "assets/images/strawberry.jpg", 1.35,
      "Fresh strawberry from Poland", "Strawberry"),
  new Product(543, "assets/images/tomatoes.jpg", 0.85,
      "Fresh tomatoes from Germany", "Tomatoes"),
];
