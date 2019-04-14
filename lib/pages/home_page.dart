import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../widgets/game_tile_test.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';
import '../models/steam_item.dart';

import 'settings_page.dart';
import 'landing_page.dart';

import '../globals.dart' as globals;


class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  bool _isLoading;

  List<SteamItem> _items = <SteamItem>[];

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _items = globals.items;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: Center(
        child: (_items != null && _items.isNotEmpty) ? new ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) => GameTileTest(_items[index]),
        ) : _showCircularProgress(),
      ),
    );
  }

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Container(height: 0.0, width: 0.0);
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