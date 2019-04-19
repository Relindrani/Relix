import 'package:flutter/material.dart';

import '../models/item.dart';

import '../widgets/search_tile.dart';

import '../globals.dart' as globals;

class SearchPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>{
  final _formKey = new GlobalKey<FormState>();

  List<Item> searchList = <Item>[];
  String _search;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _showSearchBar(),
                  _showSearchbutton()
                ],
              ),
              Expanded(
                flex: 17,
                child: (searchList != null && searchList.isNotEmpty) ? ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (context, index) => SearchTile(searchList[index]),
                ) : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showSearchBar(){
    return Expanded(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Search',
          ),
          onSaved: (value) => _search = value,
        ),
      ),
    );
  }

  Widget _showSearchbutton(){
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
        child: new IconButton(
          icon: Icon(Icons.search),
          color: Color.fromARGB(255, 6, 98, 157),
          onPressed: _searchForItem,
        )
      ),
    );
  }

  void _searchForItem(){
    _formKey.currentState.save();
    List<Item> tempList = <Item>[];
    for(final i in globals.items){
      if(i.name.toLowerCase().contains(_search.toLowerCase(), 0)){
        tempList.add(i);
      }
    }
    setState(() {
      searchList = tempList;
    });
  }
}