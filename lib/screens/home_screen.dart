import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:flutterapp/screens/shopping_list_details.dart';
import 'package:flutterapp/web_services/shopping_list_web_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Future<List<ShoppingList>> futureShoppingList;

  @override
  void initState() {
    super.initState();
    futureShoppingList = ShoppingListWS.getShoppingLists();
  }

  Widget _buildShoppingLists() {
    return FutureBuilder(
      future: futureShoppingList,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        shoppingList.title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Created on ${shoppingList.dateCreated}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade100,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "$leftToPick/${shoppingList.rows.length}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
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
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Shopping lists",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: "OpenSans",
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.start,
                        ),
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
      ),
    );
  }
}
