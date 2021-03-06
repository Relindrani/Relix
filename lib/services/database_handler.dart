import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../globals.dart' as globals;

/**
 * *Database handler class
 * *Singleton instance
 */
class DatabaseHandler{
  final FirebaseDatabase _database  = FirebaseDatabase.instance;
  
  DatabaseHandler();

  //*takes dynamic object and saves the data to database
  void addDatabaseItem(dynamic i){
    if(i != null) _saveData(i);
  }

  /**
   * *Removes item from database
   * TODO: implement
   */
  void removeDatabaseItem(){
    
  }
  //*Removes all items from database
  void removeAllDatabaseItems(){
    _database.reference().child(globals.userId).remove();
  }

  //*Loads database into list of items, called on init of landing page
  Future<List<Item>> loadDataBase()async{
    Map itemMap;
    await _loadData().then((result){
      itemMap = result;
    });
    List<Item> items = <Item>[];
    
    if(itemMap != null) itemMap.forEach((key, value) {
      Item item;
      Item test;
      test = Item.fromJson(value);
      switch(test.category){
        case Categories.GAME:
          item = new Game();
          item = Game.fromJson(value);
          break;
        case Categories.CONSOLE:
          item = new Console();
          item = value.fromJson();
          break;
        case Categories.CONSOLE_ACCESSORY:
          item = new ConsoleAccessory();
          item = value.fromJson();
          break;
        case Categories.BOOK:
          item = new Book();
          item = value.fromJson();
          break;
        case Categories.FIGURE:
          item = new Figure();
          item = value.fromJson();
          break;
        case Categories.COLLECTORS_EDITION:
          item = new CollectorsEdition();
          item = value.fromJson();
          break;
        case Categories.CLOTHING:
          item = new Clothing();
          item = value.fromJson();
          break;
        case Categories.ACCESSORY:
          item = new Accessory();
          item = value.fromJson();
          break;
        default:
          item = new Item();
          item = Item.fromJson(value);
      }
      items.add(item);
    });

    items.sort((a,b) => a.name.compareTo(b.name));
    return items;
  }
  
}

const jsonCodec = const JsonCodec(reviver: _reviver);

//*encodes item data using toJson functions and posts it to database url in json format
_saveData(dynamic item) async{
  var json = jsonCodec.encode(item);

  var url = "https://relix-3f992.firebaseio.com/" + globals.userId + "/items.json";
  var response = await http.post(url, body: json);
}
//*retrieves and decodes data returning map object that can be read using fromJson functions to get item object
Future<Map>_loadData() async{
  var url = "https://relix-3f992.firebaseio.com/" + globals.userId + "/items.json";
  var response = await http.get(url);

  Map items = jsonCodec.decode(response.body);

  return items;
}

_reviver(key, value){
  return value;
}