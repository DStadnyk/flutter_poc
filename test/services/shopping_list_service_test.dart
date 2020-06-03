import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/services/mock_provider_service.dart';
import 'package:flutterapp/services/provider_service.dart';
import 'package:flutterapp/services/shopping_list_service.dart';

void main() {
  ShoppingListService _sut;
  ProviderService _mockProvider;

  setUp(() {
    _mockProvider = MockProviderService();
    _sut = ShoppingListService(_mockProvider);
  });

  test('sut is created', () {
    expect(_sut, isNotNull);
  });

  test('get non empty shopping list array from provider', () async {
    const customerId =  "Julianna.Ellesworth@gmail.com";
    var actual = await _sut.getDataAsync(customerId);

    expect(actual.length, isNot(0));
  });


}
