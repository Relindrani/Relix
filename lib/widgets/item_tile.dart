import 'package:flutter/material.dart';

import 'dart:convert';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../pages/item_page.dart';

import '../globals.dart' as globals;

/**
 * *Widget that displays item information on a tile
 * *Has picture, name and category shown
 */
class ItemTile extends StatelessWidget{
  final dynamic _item;
  ItemTile(this._item);

  @override
  Widget build(BuildContext context){
    return Card(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox.expand(
                child: (_item.picPath != null && _item.picPath != "") ? (_item is Game && _item.isSteamGame) ? Image.network(_item.picPath) : Image.memory(base64.decode(_item.picPath), fit: BoxFit.fill,): Center(child: Text("No Image")),
              )
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 5.0,
                    left: 5.0,
                    right: 5.0,
                    child: Text(_item.name, textAlign: TextAlign.center,maxLines: 2,),
                  ),
                  Positioned(
                    bottom: 5.0,
                    left: 5.0,
                    right: 5.0,
                    child: Text(CategoryEnumMap[_item.category], textAlign: TextAlign.center,)
                  )
                ],
              ),
            ),
          ],
        ),
        onTap: () => _goToItemPage(context, _item),
      ),
    );
  }

  _goToItemPage(BuildContext context, dynamic _item){
    while(globals.recentlyViewed.length >= 10) globals.recentlyViewed.removeFirst();
    globals.recentlyViewed.add(_item);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage(_item)));
  }
}