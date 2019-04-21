import 'dart:convert';

import 'package:flutter/material.dart';

import '../pages/item_page.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../globals.dart' as globals;

/**
 * *Widget that shows long item tile for display on search page
 */
class SearchTile extends StatelessWidget{
  final dynamic _item;
  SearchTile(this._item);

  @override
  Widget build(BuildContext context){
    return InkWell(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(_item.name),
            subtitle: Text(CategoryEnumMap[_item.category]),
            leading: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: (_item.picPath != null && _item.picPath != "") ? (_item is Game && _item.isSteamGame) ? Image.network(_item.picPath, height: 50.0,) : Image.memory(base64.decode(_item.picPath), height: 50.0, fit: BoxFit.fill,): Center(child: Text("No Image")),
            ),
          ),
          Divider()
        ],
      ),
      onTap: () => _goToItemPage(context, _item),
    );
  }

  _goToItemPage(BuildContext context, dynamic _item){
    while(globals.recentlyViewed.length >= 10) globals.recentlyViewed.removeFirst();
    globals.recentlyViewed.add(_item);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage(_item)));
  }
}