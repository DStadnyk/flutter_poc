import 'dart:async';
import 'package:flutterapp/blocs/bloc.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/services/customer_service.dart';
import 'package:flutterapp/services/shopping_list_service.dart';

class ShoppingListBloc implements bloc {
  String _customerId;
  List<ShoppingList> _list;
  List<ShoppingList> get list => _list;

  CustomerService _customerService;
  ShoppingListService _shoppingListService;

  final _controller = StreamController<List<ShoppingList>>();
  Stream<List<ShoppingList>> get shoppingListStream => _controller.stream;

  ShoppingListBloc(this._customerService, this._shoppingListService) {
    _customerId = _customerService.getCustomer();
  }
  
  void uppdateShoppingList() async {
    final results = await _shoppingListService.getShoppingListsAsync(_customerId);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}