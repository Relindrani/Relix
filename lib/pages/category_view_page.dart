import 'package:flutter/material.dart';

import '../models/item.dart';

import '../widgets/category_view_tile.dart';

import '../globals.dart' as globals;

class CategoryViewPage extends StatelessWidget{

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
          itemBuilder: (context, index) => CategoryViewTile(Categories.values[index]),
        )
      )
    );
  }
}