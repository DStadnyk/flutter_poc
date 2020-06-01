import 'package:flutter/material.dart';

class CreateShoppingListScreen extends StatefulWidget {
  @override
  _CreateShoppingListScreenState createState() =>
      _CreateShoppingListScreenState();
}

class _CreateShoppingListScreenState extends State<CreateShoppingListScreen> {
  final _createShoppingListFormScreenKey = GlobalKey<FormState>();

  Widget _buildShoppingListNameTF() {
    return TextField(
      style: TextStyle(
        color: Colors.grey.shade900,
      ),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.grey.shade800,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        hintText: 'Enter a name here ...',
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff990f99),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
        title: Text(
          'Create shopping list',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _createShoppingListFormScreenKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildShoppingListNameTF(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
