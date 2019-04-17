import 'package:flutter/material.dart';
import '../widgets/item_tile.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../globals.dart' as globals;

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  bool _isLoading = false;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Center(
        child: (globals.items != null && globals.items.isNotEmpty) ? new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: globals.items.length,
          itemBuilder: (context, index) => ItemTile(globals.items[index]),
        ) : _showCircularProgress(),
      )
    );
  }

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Text("No Items Found");
  }
}