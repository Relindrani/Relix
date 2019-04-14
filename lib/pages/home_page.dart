import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../widgets/game_tile_test.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';
import '../models/steam_item.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  List<SteamItem> _items = <SteamItem>[];

  Future<List<SteamItem>> getItems() async{
    String url = 'http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=8BCD4971534B22531611F207DEA0FD47&steamid=76561198067155644&include_appinfo=%27true%27&format=json';
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      var rest = data["response"]["games"] as List;
      if(rest != null) _items = rest.map<SteamItem>((json) => SteamItem.fromJson(json)).toList();
    }
    else throw Exception('Failed to load');

    _items.sort((a, b) => a.name.compareTo(b.name));

    return _items;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: Center(
        child: FutureBuilder<List<SteamItem>>(
          future: getItems(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) => GameTileTest(_items[index]),
              );
            } else if(snapshot.hasError)return Text("${snapshot.error}");
            return CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}

/**
 * ?Call API request on button press
        RaisedButton(
          onPressed: (){
            fetchPost().then((result) {
                print('In Builder');
            })
          },
          child: Text('Get data'),
        )

        RaisedButton(
          onPressed: () async {
            var result = await fetchPost()
            print('In Builder');
          },
          child: Text('Get data'),
        )
 */