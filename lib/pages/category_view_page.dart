import 'package:flutter/material.dart';

import '../models/item.dart';

import '../widgets/category_view_tile.dart';

/**
 * *Page to show different categories
 * *Displays a gridview with 1 colum consisting of all the Categories as tiles
 */
class CategoryViewPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.white,
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