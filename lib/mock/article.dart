class Article {
  int id;
  String gtin;
  String name;
  int quantity;
  bool checked;
  bool crossed;
  String categoryName;

  Article(this.id, this.gtin, this.name, this.quantity, this.checked,
      this.crossed, this.categoryName);
}

final List<Article> articles = [
  new Article(101, "021SAD-SD32", "Nescafe", 3, true, true, "Coffee"),
  new Article(102, "021SAD-LG22", "Coca-Cola", 5, false, false, "Drinks"),
  new Article(
      103,
      "213SAD-FG32",
      "Pringles",
      10,
      true,
      true,
      "Snacks"),
  new Article(
      104,
      "0FUSA2-POI2",
      "Dr. Pepper",
      2,
      false,
      true,
      "Drinks"),
  new Article(105, "3FKG45-GD32", "Corona Extra", 4, false, false, "Beer"),
];
