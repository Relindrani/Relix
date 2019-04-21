import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../services/authentication.dart';
import '../services/database_handler.dart';

import '../models/steam_item.dart';
import '../models/item.dart';
import '../models/itemTypes.dart';

import '../globals.dart' as globals;

class SettingsPage extends StatefulWidget{

  SettingsPage({Key key, this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

/**
 * *Settings page of app
 * *Contains field for inputting steam profile id to import library
 * TODO: Playstation and XBox import
 * *Also has buttons for clearing all data, resetting password (NYI), and signing out
 * TODO: Reset password function
 * *Form state key for handling form data (steam input) and database handler object for adding items to database
 * *List of steam items to populate from steam api
 */
class SettingsPageState extends State<SettingsPage>{
  final _formKey = new GlobalKey<FormState>();

  final DatabaseHandler _handler = new DatabaseHandler();

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

  //*Input steam profile id to import library
  Widget _showSteamInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Steam Profile Id: '
        ),
        validator: (value) => value.isEmpty ? 'Steam Id Field can\'t be empty' : null,
        onSaved: (value) => _steamId = value,
      ),
    );
  }

  //*Button to import
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
        ///*On pressed function
        ///TODO: move to separate function
        ///*validates and saves form
        ///*if list is empty, adds entire result into list
        ///*if list isn't empty, compares results appid with list to only add new games and keeps count of new ones added
        ///*if global list is empty, adds all the steam items
        ///*if globals list is not empty, compares name to only add new items
        onPressed: () async{
          setState(() {
            _isLoading = true; 
          });
          if(_formKey.currentState.validate())_formKey.currentState.save();
          if(_items.isEmpty || _items == null){
            await getItems().then((result){
              setState(() {
                _items = result;
                _steamErrorMessage = 'Successfully added '+_items.length.toString()+' games!';
              });
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
            setState(() {
              _steamErrorMessage = 'Successfully added '+gamesAdded.toString()+' games!';
            });
          }
          if(globals.items.isEmpty || globals.items == null){
            for(final i in _items){
              Game g = new Game(name: i.name, category: Categories.GAME, picPath: 'http://media.steampowered.com/steamcommunity/public/images/apps/' + i.appId.toString() + '/' + i.logoUrl + '.jpg', desc: 'desc', price: 0.0, purchasedAt: 'Steam', platform: Platform.PC, isSteamGame: true, isDigital: true, caseType: Case.NO_CASE, series: '', complete: CompleteStatus.NOT_PLAYED);
              _addNewItemToDatabase(g);
            } 
          }else{
            for(final i in _items){
              int counter = 0;
              for(final j in globals.items){
                if(i.name == j.name) break;
                else counter++;
              }
              if(counter >= _items.length){
                Game g = new Game(name: i.name, category: Categories.GAME, picPath: 'http://media.steampowered.com/steamcommunity/public/images/apps/' + i.appId.toString() + '/' + i.logoUrl + '.jpg', desc: 'desc', price: 0.0, purchasedAt: 'Steam', platform: Platform.PC, isSteamGame: true, isDigital: true, caseType: Case.NO_CASE, series: '', complete: CompleteStatus.NOT_PLAYED);
                _addNewItemToDatabase(g);
              } 
            }
          }
          setState(() {
            _isLoading = false;
          });
          globals.items.sort((a, b) => a.name.compareTo(b.name));
        },
      ),
    );
  }

  //*Shows steam error message (Not necessarily error)
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

  //*Sign out button returns user to login screen
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

  /**
   * *Reset password button
   * TODO: implement
   */
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
        onPressed: () {
          
        },
      )
    );
  }

  //*Button to clear all data
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
        onPressed: () => _clearAllData(),
      )
    );
  } 

  /**
   * *Gets Steam item information from steam api
   * *if response is successful, decode the body and look for the information for each game
   * *Populate that information as a list
   * *As long as that list is not null, map the information to a SteamItem using the fromJson function
   * *Then sorts the list of items and returns it
   */
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

  /**
   * *Adds new item to firebase using handler object
   * *Adds new item to global list
   * *Checks length of recently added queue and removes first until length is less than 10 then adds new item to the end
   */
  void _addNewItemToDatabase(Item i){
    _handler.addDatabaseItem(i);
    globals.items.add(i);
    while(globals.recentlyAdded.length >= 10) globals.recentlyAdded.removeFirst();
    globals.recentlyAdded.add(i);
  }

  //*Shows dialog box to confirm clearing all data in database and variables list
  void _clearAllData(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Clear all data"),
          content: new Text("This will delete your entire collection"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Yes"),
              onPressed: (){
                _handler.removeAllDatabaseItems();
                globals.items.clear();
                globals.recentlyAdded.clear();
                globals.recentlyViewed.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}