import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/services/mock_provider_service.dart';
import 'package:flutterapp/services/provider_service.dart';
import 'package:flutterapp/services/shopping_list_service.dart';

void main() {
  const _customerId = "Julianna.Ellesworth@gmail.com";

  ShoppingListService _sut;
  ProviderService _mockProvider;

  setUp(() {
    _mockProvider = MockProviderService();
    _sut = ShoppingListService(_mockProvider);
  });

  test('Sut is created', () {
    expect(_sut.runtimeType, ShoppingListService);
  });

  test('Get non empty shopping list array from provider', () async {
    var actual = await _sut.getShoppingListsAsync(_customerId);

    expect(actual.first.runtimeType, ShoppingList);
  });

  test(
      'Create a shopping list called Electronics for user Juliana.Ellesworth@gmail.com',
      () async {
    var actual = await _sut.createShoppingListAsync(_customerId, 'Electronics');

    expect(actual.customerId, _customerId);
  });

  test('Delete a shopping list with a specific id', () async {
    var id = 186;

    var actual = await _sut.deleteShoppingListAsync(id);

    expect(actual, true);
  });
}
