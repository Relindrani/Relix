import 'package:flutter/material.dart';

import '../models/item.dart';
import 'small_item_tile.dart';

import '../globals.dart' as globals;

import '../pages/item_list_view_page.dart';

class CategoryViewTile extends StatelessWidget{
  final Categories _cat;
  final List<Item> _items;
  CategoryViewTile(this._cat, this._items);

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
              fit: FlexFit.tight,
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
                child: (_items != null && _items.isNotEmpty) ? new GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) { 
                    for(var i = offset; i < _items.length; i++){
                      if(_items[i].category == _cat){
                        offset++;
                        return new SmallItemTile(_items[i]);
                      }
                    }
                    return new Card();
                  }
                ) : Text("No items found"),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListViewPage(_cat, _items))),
      ),
    );
  }

  List<Item> getCategoryItems(Categories cat){
    List<Item> i = <Item>[];
    for(final item in _items){
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