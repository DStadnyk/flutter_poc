import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buildSliverAppBar() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: SizedBox(),
          expandedHeight: 200.0,
          floating: true,
          pinned: true,
          snap: true,
          elevation: 50,
          backgroundColor: Color.fromRGBO(152, 100, 227, 1),
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              background: Image.asset(
                'assets/images/ExtendaRetail_thumb.jpg',
                fit: BoxFit.cover,
              )),
        ),
        new SliverList(delegate: new SliverChildListDelegate(_buildList(50))),
      ],
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _buildSliverAppBar(),
    );
  }
}

//member id
//server address
//member id shoppinglist
//language
