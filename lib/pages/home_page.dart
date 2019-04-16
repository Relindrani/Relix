import 'package:flutter/material.dart';
import '../widgets/item_tile.dart';

import '../models/item.dart';

import '../globals.dart' as globals;

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  bool _isLoading;

  List<Item> _items = <Item>[];

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _items = globals.items;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Center(
        child: (_items != null && _items.isNotEmpty) ? new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: _items.length,
          itemBuilder: (context, index) => ItemTile(_items[index]),
        ) : _showCircularProgress(),
      )
    );
  }

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Text("No Items Found");
  }
}