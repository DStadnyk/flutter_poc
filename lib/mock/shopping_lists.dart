class ShoppingList {
  int id;
  String title;
  String customerId;
  String dateCreated;
  int checkedAmount;
  int amount;

  ShoppingList(this.id, this.title, this.customerId, this.dateCreated,
      this.checkedAmount, this.amount);
}

final List<ShoppingList> shoppingLists = [
  new ShoppingList(100, 'Bakery products', "421", "18 July 2020", 3, 12),
  new ShoppingList(101, 'Vegetables', "421", "21 September 2019", 4, 7),
  new ShoppingList(102, 'Household products', "421", "3 April 2020", 1, 4),
  new ShoppingList(103, 'Household products', "421", "3 April 2020", 8, 10),
  new ShoppingList(104, 'Household products', "421", "3 April 2020", 3, 23),
  new ShoppingList(105, 'Household products', "421", "3 April 2020", 1, 3),
  new ShoppingList(106, 'Household products', "421", "3 April 2020", 3, 9),
];
