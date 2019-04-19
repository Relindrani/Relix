import 'package:flutter/material.dart';

import '../models/item.dart';
import 'small_item_tile.dart';

import '../globals.dart' as globals;

import '../pages/item_list_view_page.dart';

class CategoryViewTile extends StatelessWidget{
  final Categories _cat;
  CategoryViewTile(this._cat);

  int offset = 0;
  
  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 50.0,
      color: Color.fromARGB(255, 6, 98, 157),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  formatTextPlural(_cat.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 16,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: (globals.items != null && globals.items.isNotEmpty) ? new GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) { 
                    for(int i = offset; i < globals.items.length; i++){
                      if(globals.items[i].category == _cat || _cat == Categories.ALL_ITEM){
                        offset++;
                        return new SmallItemTile(globals.items[i]);
                      }
                      offset++;
                    }
                    return new Container(color: Colors.blueGrey,);
                  }
                ) : new Container(color: Colors.blueGrey,),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListViewPage(_cat))),
      ),
    );
  }

  List<Item> getCategoryItems(Categories cat){
    List<Item> i = <Item>[];
    for(final item in globals.items){
      if(item.category == cat){
        i.add(item);
      }
    }
    return i;
  }

  String formatTextPlural(String s){
    s = s.substring(s.indexOf('.') + 1, s.indexOf('.') + 2).toUpperCase() + s.substring(s.indexOf('.') + 2).toLowerCase() + 's';
    if(s.contains('_'))s = s.substring(0, s.indexOf('_')) + ' ' + s.substring(s.indexOf('_') + 1, s.indexOf('_') + 2).toUpperCase() + s.substring(s.indexOf('_') + 2).toLowerCase();
    if(s.contains('ys'))s = s.replaceAll('ys', 'ies');
    if(s.contains('ings'))s = s.replaceAll('ings', 'ing');
    return s;
  }
}