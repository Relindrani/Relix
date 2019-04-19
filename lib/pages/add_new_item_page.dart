import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import '../services/database_handler.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import 'landing_page.dart';

import '../globals.dart' as globals;

class AddNewItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddNewItemPageState();
}

class AddNewItemPageState extends State<AddNewItemPage>{
  final _formKey = new GlobalKey<FormState>();

  final DatabaseHandler _handler = new DatabaseHandler();

  File _image;
  bool _isDigitalGame = false;
  String _name, _desc, _purchasedAt, _series = "";
  double _price = 0.0;

  Categories _cat = Categories.OTHER;
  Platform _plat = Platform.OTHER;
  Case _case = Case.NO_CASE;
  CompleteStatus _comp = CompleteStatus.NOT_PLAYED;
  BookType _book = BookType.OTHER;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Item"),
      ),
      body: Center(
        child: _showBody()
      ),
    );
  }

  Widget _showBody(){
    switch (_cat){
      case Categories.GAME:
        return _showGameBody();
        break;
      case Categories.CONSOLE:
        return _showConsoleBody();
        break;
      case Categories.CONSOLE_ACCESSORY:
        return _showConsoleAccessoryBody();
        break;
      case Categories.BOOK:
        return _showBookBody();
        break;
      case Categories.FIGURE:
        return _showFigureBody();
        break;
      case Categories.COLLECTORS_EDITION:
        return _showCollectorsEditionBody();
        break;
      case Categories.CLOTHING:
        return _showClothingBody();
        break;
      case Categories.ACCESSORY:
        return _showAccessoryBody();
        break;
      default:
        return _showDefaultBody();
    }
  }

  Widget _showDefaultBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showEmptyContainer(13),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showGameBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showPlatformDropDown(),
            Row(children: <Widget>[
              _showDigitalGameCheck(),
              _showCaseStatusDropDown()
            ],),
            _showCompleteStatusDropDown(),
            _showEmptyContainer(1),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showConsoleBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showPlatformDropDown(),
            _showEmptyContainer(10),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showConsoleAccessoryBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showPlatformDropDown(),
            _showEmptyContainer(10),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showBookBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showBookTypeDropDown(),
            _showEmptyContainer(7),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showFigureBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showEmptyContainer(10),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showCollectorsEditionBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showPlatformDropDown(),
            _showEmptyContainer(7),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showClothingBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showEmptyContainer(10),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }
  Widget _showAccessoryBody(){
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showCategoryDropDown(),
            _showImage(),
            _showNameField(),
            _showDescriptionField(),
            _showSeriesField(),
            Row(children: <Widget>[
              _showPriceField(),
              _showPurchasedAtField()
            ],),
            _showEmptyContainer(10),
            _showSubmitButton(),
            _showTrailingContainer()
          ],
        ),
      ),
    );
  }

  Widget _showSubmitButton(){
    return Expanded(
      flex: 2,
      child: new MaterialButton(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        elevation: 5.0,
        color: Color.fromARGB(255, 6, 98, 157),
        child: new Text(
          "Add New Item",
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white
          ),
        ),
        onPressed: _validateAndSubmit,
      ),
    ); 
  }

  Widget _showImage(){
    return Expanded(
      flex: 9,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: InkWell(
          child: SizedBox.expand(
            child: (_image == null) ? Center(
              child: Text("Tap to take picture")
            ) : Container(
              child: Image.file(_image, fit: BoxFit.fill,),
            ),
          ),
          onTap: getImage,
        )
      )
    );
  }

  Widget _showNameField(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: TextFormField(
          maxLines: 1,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Item Name',
          ),
          validator: (value) => value.isEmpty ? "Name cannot be empty" : null,
          onSaved: (value) => _name = value,
        ),
      )
    );
  }
  Widget _showCategoryDropDown(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<Categories>(
            isExpanded: true,
            hint: Text("Select Category"),
            value: _cat,
            onChanged: (Categories newCat){
              setState(() {
                _cat = newCat;
              });
            },
            items: getCategoriesList(),
          ),
        ),
      ),
    );
  }
  Widget _showDescriptionField(){
    return Expanded(
      flex: 6,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: TextFormField(
          maxLines: 4,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Item Description',
          ),
          onSaved: (value) => value.isEmpty ? _desc = "" : _desc = value,
        ),
      )
    );
  }
  Widget _showPriceField(){
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
        child: TextFormField(
          maxLines:1,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            hintText: 'Price',
          ),
          onSaved: (value) => value.isEmpty ? _price = 0.0 : _price = double.parse(value),
        ),
      ),
    );
  }
  Widget _showPurchasedAtField(){
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Purchased At',
          ),
          onSaved: (value) => value.isEmpty ? _purchasedAt = "" : _purchasedAt = value,
        ),
      )
    );
  }

  Widget _showPlatformDropDown(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<Platform>(
            isExpanded: true,
            hint: Text("Select Platform"),
            value: _plat,
            onChanged: (Platform newPlat){
              setState(() {
                _plat = newPlat;
              });
            },
            items: getPlatformList(),
          ),
        ),
      )
    );
  }
  Widget _showDigitalGameCheck(){
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: CheckboxListTile(
          title: Text("Digital Game: "),
          value: _isDigitalGame,
          onChanged: (value){
            setState(() {
              _isDigitalGame = value;
            });
          },
        ),
      ),
    );
  }
  Widget _showCaseStatusDropDown(){
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<Case>(
            hint: Text("Select Case Type"),
            isExpanded: true,
            value: _case,
            onChanged: (!_isDigitalGame) ? (Case newCase){
              setState(() {
                _case = newCase;
              });
            } : null,
            items: getCaseList(),
          ),
        )
      )
    );
  }
  Widget _showSeriesField(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: TextFormField(
          maxLines: 1,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Series',
          ),
          onSaved: (value) => value.isEmpty ? _series = "" : _series = value,
        ),
      )
    );
  }
  Widget _showCompleteStatusDropDown(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<CompleteStatus>(
            hint: Text("Select Completion Status"),
            isExpanded: true,
            value: _comp,
            onChanged: (CompleteStatus newComp){
              setState(() {
                _comp = newComp;
              });
            },
            items: getCompleteList(),
          ),
        )
      )
    );
  }

  Widget _showBookTypeDropDown(){
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<BookType>(
            hint: Text("Select Book Type"),
            isExpanded: true,
            value: _book,
            onChanged: (BookType newBook){
              setState(() {
                _book = newBook;
              });
            },
            items: getBookList(),
          ),
        )
      )
    );
  }
  Widget _showEmptyContainer(int exp){
    return Expanded(
      flex: exp,
      child: Container(),
    );
  }
  Widget _showTrailingContainer(){
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  String formatCategoriesText(String s){
    s = s.substring(s.indexOf('.') + 1, s.indexOf('.') + 2).toUpperCase() + s.substring(s.indexOf('.') + 2).toLowerCase();
    if(s.contains('_'))s = s.substring(0, s.indexOf('_')) + ' ' + s.substring(s.indexOf('_') + 1, s.indexOf('_') + 2).toUpperCase() + s.substring(s.indexOf('_') + 2).toLowerCase();
    return s;
  }
  String formatPlatformText(String s){
    s = s.substring(s.indexOf('.')+1);
    if(s.contains('_'))s = s.substring(0, s.indexOf('_')) + ' ' + s.substring(s.indexOf('_') + 1);
    return s;
  }

  List<DropdownMenuItem<Categories>> getCategoriesList(){
    List<DropdownMenuItem<Categories>> cats = <DropdownMenuItem<Categories>>[];
    for(int i = 1; i < Categories.values.length; i++){
      cats.add(new DropdownMenuItem(
        value: Categories.values[i],
        child: new Text(formatCategoriesText(Categories.values[i].toString()), textAlign: TextAlign.center,),
      ));
    }
    return cats;
  }
  List<DropdownMenuItem<Platform>> getPlatformList(){
    List<DropdownMenuItem<Platform>> plats = <DropdownMenuItem<Platform>>[];
    for(final p in Platform.values){
      plats.add(new DropdownMenuItem(
        value: p,
        child: new Text(formatPlatformText(p.toString())),
      ));
    }
    return plats;
  }
  List<DropdownMenuItem<Case>> getCaseList(){
    List<DropdownMenuItem<Case>> cases = <DropdownMenuItem<Case>>[];
    for(final c in Case.values){
      cases.add(new DropdownMenuItem(
        value: c,
        child: new Text(formatCategoriesText(c.toString())),
      ));
    }
    return cases;
  }
  List<DropdownMenuItem<CompleteStatus>> getCompleteList(){
    List<DropdownMenuItem<CompleteStatus>> comps = <DropdownMenuItem<CompleteStatus>>[];
    for(final c in CompleteStatus.values){
      comps.add(new DropdownMenuItem(
        value: c,
        child: new Text(formatCategoriesText(c.toString())),
      ));
    }
    return comps; 
  }
  List<DropdownMenuItem<BookType>> getBookList(){
    List<DropdownMenuItem<BookType>> books = <DropdownMenuItem<BookType>>[];
    for(final b in BookType.values){
      books.add(new DropdownMenuItem(
        value: b,
        child: new Text(formatCategoriesText(b.toString())),
      ));
    }
    return books;
  }

  void _validateAndSubmit() async{
    if(_validateAndSave()){
      try{
        Item i;
        List<int> imageBytes;
        String imgPath = "";
        if(_image != null){
          imageBytes = _image.readAsBytesSync();
          imgPath = base64.encode(imageBytes);
        }
        switch (_cat){
          case Categories.GAME:
            i = new Game(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, platform: _plat, isSteamGame: false, isDigital: _isDigitalGame, caseType: _case, series: _series, complete: _comp);
            break;
          case Categories.CONSOLE:
            i = new Console(_name, _cat, imgPath, _desc, _price, _purchasedAt, _plat);
            break;
          case Categories.CONSOLE_ACCESSORY:
            i = new ConsoleAccessory(_name, _cat, imgPath, _desc, _price, _purchasedAt, _plat);
            break;
          case Categories.BOOK:
            i = new Book(_name, _cat, imgPath, _desc, _price, _purchasedAt, _book, _series);
            break;
          case Categories.FIGURE:
            i = new Figure(_name, _cat, imgPath, _desc, _price, _purchasedAt, _series);
            break;
          case Categories.COLLECTORS_EDITION:
            i = new CollectorsEdition(_name, _cat, imgPath, _desc, _price, _purchasedAt, _plat);
            break;
          case Categories.CLOTHING:
            i = new Clothing(_name, _cat, imgPath, _desc, _price, _purchasedAt, _series);
            break;
          case Categories.ACCESSORY:
            i = new Clothing(_name, _cat, imgPath, _desc, _price, _purchasedAt, _series);
            break;
          default:
            i = new Item(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt);
        }
        _addNewItemToDatabase(i);
        globals.items.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        Navigator.pop(context);
      }catch(e){
        print(e);
      }
    }
  }
  bool _validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _addNewItemToDatabase(Item i){
    _handler.addDatabaseItem(i);
  }
}