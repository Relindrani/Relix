import 'package:flutter/material.dart';

import 'dart:convert';

import '../models/itemTypes.dart';

//*Widget to display a smaller item tile with picture and name in category tile preview
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
              child: (_item.picPath != null) ? (_item is Game && _item.isSteamGame) ? Image.network(_item.picPath) : Image.memory(base64.decode(_item.picPath)): Center(child: Text("No Image"))
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
}