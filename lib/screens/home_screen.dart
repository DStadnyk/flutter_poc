import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/blocs/shopping_list_bloc.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/screens/create_shopping_list.dart';
import 'package:flutterapp/screens/shopping_list_details.dart';
import 'package:flutterapp/services/customer_service.dart';
import 'package:flutterapp/services/provider_service.dart';
import 'package:flutterapp/services/shopping_list_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ShoppingListBloc _block;

  @override
  void initState() {
    super.initState();
    _block = ShoppingListBloc(
        CustomerService(), ShoppingListService(ProviderService()));
    _block.uppdateShoppingList();
  }

  Widget _buildShoppingLists() {
    return StreamBuilder<List<ShoppingList>>(
      stream: _block.shoppingListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: AnimatedList(
              key: _listKey,
              shrinkWrap: false,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20),
              initialItemCount: snapshot.data.length,
              itemBuilder: (context, index, animation) {
                return _buildShoppingListItem(snapshot.data[index], animation);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Expanded(
            child: Center(
                child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff990f99)),
        )));
      },
    );
  }

  Widget _buildShoppingListCard(ShoppingList shoppingList) {
    int leftToPick = shoppingList.rows.length - shoppingList.getCrossedAmount();
    var cardColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShoppingListDetailsScreen(
                        shoppingList: shoppingList,
                        backgroundColor: cardColor,
                      )));
        },
        child: Hero(
          tag: shoppingList.id,
          child: Material(
            color: Colors.white,
            child: Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: cardColor.withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: Offset(6, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        shoppingList.title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "$leftToPick/${shoppingList.rows.length}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade100,
                            ),
                            children: [
                              TextSpan(text: 'Created by '),
                              TextSpan(
                                text: shoppingList.customerId,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingListItem(
      ShoppingList shoppingList, Animation animation) {
    return SizeTransition(
        sizeFactor: animation, child: _buildShoppingListCard(shoppingList));
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Color(0xff990f99),
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_basket),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Notifications'),
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
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Shopping lists",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      MaterialButton(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              'Create',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateShoppingListScreen()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Color(0xff990f99),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildShoppingLists(),
              ],
            )),
      ),
    );
  }
}
