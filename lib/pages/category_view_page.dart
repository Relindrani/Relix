import 'package:flutter/material.dart';

import '../models/item.dart';

import '../widgets/category_view_tile.dart';

import '../globals.dart' as globals;

class CategoryViewPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => CategoryViewPageState();
}

class CategoryViewPageState extends State<CategoryViewPage>{

  List<Item> _items = <Item>[];

  @override
  void initState(){
    super.initState();
    _items = globals.items;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories"),
      ),
      body: Center(
        child: new GridView.builder(
          padding: EdgeInsets.all(10.0),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          itemCount: Categories.values.length,
          itemBuilder: (context, index) => CategoryViewTile(Categories.values[index], _items),
        )
      )
    );
  }
}