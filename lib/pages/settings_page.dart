import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../services/authentication.dart';

import '../models/steam_item.dart';
import '../models/item.dart';
import '../models/itemTypes.dart';

import 'landing_page.dart';

import '../globals.dart' as globals;

class SettingsPage extends StatefulWidget{

  SettingsPage({Key key, this.auth, this.userId, this.onSignedOut});

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>{
  final _formKey = new GlobalKey<FormState>();

  List<SteamItem> _items = <SteamItem>[];

  String _steamId;
  String _steamErrorMessage;

  bool _isLoading;

  @override
  void initState(){
    super.initState();
    _steamErrorMessage = "";
    _steamId = "";
    _isLoading = false;
    _items = globals.steamGames;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
      ),
      body: new Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress()
        ],
      )
    );
  }

  Widget _showBody(){
    return new Container(
      padding: EdgeInsets.all(36.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showSteamInput(),
            _showSteamInputButton(),
            _showSteamErrorMessage(),
            Padding(padding: EdgeInsets.only(top: 200.0),),
            _showClearDataButton(),
            _showResetPasswordButton(),
            _showSignOutButton()
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Container(height: 0.0, width: 0.0);
  }

  Widget _showSteamInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Steam Profile Id: 76561198067155644'
        ),
        validator: (value) => value.isEmpty ? 'Steam Id Field can\'t be empty' : null,
        onSaved: (value) => _steamId = value,
      ),
    );
  }

  Widget _showSteamInputButton(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42.0,
        color: Color.fromARGB(255, 6, 98, 157),
        child: new Text(
          "Sync Steam Games",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
        ),
        onPressed: () async{
          if(_formKey.currentState.validate())_formKey.currentState.save();
          if(_items.isEmpty || _items == null){
            await getItems().then((result){
              _items = result;
              _steamErrorMessage = 'Successfully added '+_items.length.toString()+' games!';
              setState(() {});
            });
          }else{
            int counter, gamesAdded = 0;
            await getItems().then((result){
              for(final i in result){
                counter = 0;
                for(final j in _items){
                  if(i.appId == j.appId)break;
                  else counter++;
                }
                if(counter == _items.length){
                  _items.add(i);
                  gamesAdded++;
                }
              }
            });
            _steamErrorMessage = 'Successfully added '+gamesAdded.toString()+' games!';
            setState(() {});
          }
          if(globals.items.isEmpty || globals.items == null){
            for(final i in _items) globals.items.add(new Game(i.name, Categories.GAME, 'http://media.steampowered.com/steamcommunity/public/images/apps/' + i.appId.toString() + '/' + i.logoUrl + '.jpg', 'desc', 0.0, 'Steam', Platform.PC, true, true, Case.NO_CASE, '', CompleteStatus.NOT_PLAYED));
          }else{
            for(final i in _items){
              int counter = 0;
              for(final j in globals.items){
                if(i.name == j.name) break;
                else counter++;
              }
              if(counter <= _items.length) globals.items.add(new Game(i.name, Categories.GAME, 'http://media.steampowered.com/steamcommunity/public/images/apps/' + i.appId.toString() + '/' + i.logoUrl + '.jpg', 'desc', 0.0, 'Steam', Platform.PC, true, true, Case.NO_CASE, '', CompleteStatus.NOT_PLAYED));
            }
          }
          globals.items.sort();
        },
      ),
    );
  }

  Widget _showSteamErrorMessage(){
    if(_steamErrorMessage.length > 0 && _steamErrorMessage != null){
      return new Text(
        _steamErrorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    }else return new Container(height: 20.0,);
  }

  Widget _showSignOutButton(){
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 500.0,
        height: 42.0,
        color: Color.fromARGB(255, 6, 98, 157),
        child: new Text(
          "Sign Out",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
        ),
        onPressed: () => widget.onSignedOut(),
      )
    );
  }

  Widget _showResetPasswordButton(){
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 500.0,
        height: 42.0,
        color: Color.fromARGB(255, 6, 98, 157),
        child: new Text(
          "Reset Password",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
        ),
        onPressed: () {},
      )
    );
  }

  Widget _showClearDataButton(){
    return new Align(
      alignment: FractionalOffset.bottomCenter,
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 500.0,
        height: 42.0,
        color: Colors.red,
        child: new Text(
          "Clear Data",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
        ),
        onPressed: () {},
      )
    );
  } 

  Future<List<SteamItem>> getItems() async{
    String url = 'http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=8BCD4971534B22531611F207DEA0FD47&steamid=$_steamId&include_appinfo=%27true%27&format=json';
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      var rest = data["response"]["games"] as List;
      if(rest != null) _items = rest.map<SteamItem>((json) => SteamItem.fromJson(json)).toList();
    }
    else{
      _steamErrorMessage = 'Unable to load library. Confirm you entered profile ID correctly and make sure your game library is set to public in steam settings.';
      setState(() {});
      throw Exception('Failed to load');
    }

    _items.sort((a, b) => a.name.compareTo(b.name));

    return _items;
  }
}