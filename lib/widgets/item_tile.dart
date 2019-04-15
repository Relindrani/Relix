import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

class ItemTile extends StatelessWidget{
  final Item _item;
  ItemTile(this._item);

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        InkWell(
          child: ListTile(
            title: Text(_item.name),
            subtitle: Text(_item.category.toString().substring(_item.category.toString().indexOf('.')+1)),
            leading: Container(
              child: (_item.picPath != null) ? Image.network('http://media.steampowered.com/steamcommunity/public/images/apps/3830/b361ab26b2c47d4abd11be0ebd3d6b675512ec1b.jpg') : Container(),
            ),
          ),
          onTap: (){},
        ),
        Divider()
      ],
    );
  }
}