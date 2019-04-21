import 'package:flutter/material.dart';

import '../widgets/item_tile.dart';
import '../models/item.dart';

import '../globals.dart' as globals;

/**
 * *Page to display grid list of all items within category
 * *Constructor compares the category passed with global item list to see how many items are within that category
 * *Creates gridview builder with length of number of items in category
 * *Keeps track of offset so it doesn't grab the first item in list every time it loops
 */
class ItemListViewPage extends StatelessWidget{
  final Categories _cat;
  int catCount = 0;
  ItemListViewPage(this._cat){
    if(_cat != Categories.ALL_ITEM){
      for(final i in globals.items){
        if(i.category == _cat)catCount++;
      }
    } else catCount = globals.items.length;
  }

  int offset = 0;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(formatTextPlural(CategoryEnumMap[_cat])),
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

  //*Returns plural form of CategoryEnumMap string for each category
  String formatTextPlural(String s){
    s = s + 's';
    if(s.contains('ys'))s = s.replaceAll('ys', 'ies');
    if(s.contains('ings'))s = s.replaceAll('ings', 'ing');
    return s;
  }
}