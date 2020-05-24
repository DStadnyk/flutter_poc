import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/model/product.dart';
import 'package:flutterapp/model/shopping_list.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShoppingListDetailsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  final Color backgroundColor;

  ShoppingListDetailsScreen(
      {Key key, @required this.shoppingList, @required this.backgroundColor})
      : super(key: key);

  @override
  _ShoppingListDetailsScreenState createState() =>
      _ShoppingListDetailsScreenState();
}

class _ShoppingListDetailsScreenState extends State<ShoppingListDetailsScreen> {
  ShoppingList getShoppingListObject() {
    return widget.shoppingList;
  }

  @override
  void initState() {
    super.initState();
  }

  void deleteProduct(index) {
    setState(() {
      getShoppingListObject().rows.removeAt(index);
    });
  }

  void undoProductDeletion(index, item) {
    setState(() {
      getShoppingListObject().rows.insert(index, item);
    });
  }

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Crossed",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade900,
            ),
          ),
          LinearPercentIndicator(
            width: 200,
            lineHeight: 7.0,
            percent: getShoppingListObject().getCrossedAmount() /
                getShoppingListObject().rows.length,
            trailing: Text(
              "${100 * getShoppingListObject().getCrossedAmount() ~/ getShoppingListObject().rows.length}%",
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.grey.shade300,
            linearStrokeCap: LinearStrokeCap.butt,
            progressColor: widget.backgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: false,
            physics: BouncingScrollPhysics(),
            itemCount: getShoppingListObject().rows.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildProductCard(index, context)),
      ),
    );
  }

  Widget _buildProductCard(int index, BuildContext context) {
    var product = getShoppingListObject().rows[index];

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 30),
      child: Dismissible(
        key: ObjectKey(product),
        background: _buildDismissBackdrop(),
        onDismissed: (direction) {
          Product productToDelete =
              getShoppingListObject().rows.elementAt(index);
          deleteProduct(index);
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Item deleted"),
              action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    //To undo deletion
                    undoProductDeletion(index, productToDelete);
                  })));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: widget.backgroundColor,
                    activeColor: Colors.grey.shade200,
                    value: getShoppingListObject().rows[index].crossed,
                    onChanged: (newValue) {
                      setState(() {
                        getShoppingListObject().rows[index].crossed = newValue;
                        widget.shoppingList.rows[index].crossed = newValue;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "${product.quantity.toString()} x ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Category: ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            product.categoryName,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackdrop() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.red,
      ),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.shoppingList.id,
                  child: Material(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: widget.backgroundColor.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                widget.shoppingList.title,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Created on ${widget.shoppingList.dateCreated}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                _buildProgressBar(),
                SizedBox(
                  height: 15,
                ),
                _buildProductsList(context),
              ],
            ),
            Positioned(
              top: 5,
              left: 5,
              child: _buildTopBar(),
            )
          ]),
        ),
      ),
    );
  }
}
