import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/profile.screen.dart';
import 'package:flutterapp/screens/shopping_lists.screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _screens = [
    ShoppingListsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onNavItemTapped,
      selectedItemColor: Color(0xff990f99),
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_basket),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }
}
