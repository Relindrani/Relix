import 'package:flutter/material.dart';

import '../widgets/item_tile.dart';
import '../models/item.dart';

import '../globals.dart' as globals;

class ItemListViewPage extends StatelessWidget{
  final Categories _cat;
  int catCount = 0;
  ItemListViewPage(this._cat){
    for(final i in globals.items){
      if(i.category == _cat)catCount+=1;
    }
  }

  int offset = 0;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(formatTextPlural(_cat.toString())),
      ),
      body: Center(
        child: (globals.items != null && globals.items.isNotEmpty) ? new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: catCount,
          itemBuilder: (context, index) {for(var i = offset; i < globals.items.length; i++){
              if(globals.items[i].category == _cat || _cat == Categories.ALL_ITEM){
                offset++;
                return new ItemTile(globals.items[i]);
              }
              offset++;
            }
            return new Card();
          },
        ) : Text('No Items Found'),
      )
    );
  }

  String formatTextPlural(String s){
    s = s.substring(s.indexOf('.') + 1, s.indexOf('.') + 2).toUpperCase() + s.substring(s.indexOf('.') + 2).toLowerCase() + 's';
    if(s.contains('_'))s = s.substring(0, s.indexOf('_')) + ' ' + s.substring(s.indexOf('_') + 1, s.indexOf('_') + 2).toUpperCase() + s.substring(s.indexOf('_') + 2).toLowerCase();
    if(s.contains('ys'))s = s.replaceAll('ys', 'ies');
    if(s.contains('ings'))s = s.replaceAll('ings', 'ing');
    return s;
  }
}