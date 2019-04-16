import 'package:flutter/material.dart';

import '../widgets/item_tile.dart';
import '../models/item.dart';

import '../globals.dart' as globals;

class ItemListViewPage extends StatelessWidget{
  final Categories _cat;
  final List<Item> _items;
  ItemListViewPage(this._cat, this._items);

  int offset = 0;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(formatTextPlural(_cat.toString())),
      ),
      body: Center(
        child: (_items != null && _items.isNotEmpty) ? new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            for(var i = offset; i < _items.length; i++){
              if(_items[i].category == _cat){
                offset++;
                return new ItemTile(_items[i]);
              }
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