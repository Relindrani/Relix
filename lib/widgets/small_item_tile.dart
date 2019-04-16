import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

class SmallItemTile extends StatelessWidget{
  final dynamic _item;
  SmallItemTile(this._item);

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: (_item.picPath != null) ? (_item is Game && _item.isSteamGame) ? Image.network(_item.picPath) : Image.asset(_item.picPath): Container()
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0.0,
                    left: 5.0,
                    right: 5.0,
                    child: Text(_item.name, textAlign: TextAlign.center,maxLines: 1,),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  String formatText(String s){
    s = s.substring(s.indexOf('.') + 1, s.indexOf('.') + 2).toUpperCase() + s.substring(s.indexOf('.') + 2).toLowerCase();
    if(s.contains('_'))s = s.substring(0, s.indexOf('_')) + ' ' + s.substring(s.indexOf('_') + 1, s.indexOf('_') + 2).toUpperCase() + s.substring(s.indexOf('_') + 2).toLowerCase();
    return s;
  }
}