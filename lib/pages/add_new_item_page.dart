import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import '../services/database_handler.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../globals.dart' as globals;

class AddNewItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddNewItemPageState();
}

/**
 * *Page for adding new item to collection
 * *Form state key for handling form information
 * *Database handler object for adding items to firebase
 * *image file and other information that defines items
 */
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

  //*Displays different body structures depending on item type
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

  //*Default body for 'Other' items with basic information
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
  //*Body for 'Game' items
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
  //*Body for 'Console' items
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
  //*Body for 'Console Accessory' items
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
  //*Body for 'Book' items
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
  //*Body for 'Figure' items
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
  //*Body for 'Collectors Edition' items
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
  //*Body for 'Clothing' items
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
  //*Body for 'Accessory' items
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

  //*Submit button for adding defined item to collection
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

  /**
   * *Shows box for image
   * *Tap to take or change image
   */
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

  //*Shows text field for item name, validates to make sure it is not empty
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
  //*Drop down for category selection
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
  //*Shows multi line text field for description of item
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
  //*Shows number field for inputting the price of the item
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
  //*Shows text field for where the item was purchased
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

  //*Shows dropdown for selecting platform
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
  //*Shows a check box for whether the game is digital or not
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
  //*Shows dropdown for the status of the case, only active if physical game
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
  //*Shows text field for what series the game is from
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
  //*Shows drop down for selecting completion progress in a game
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
  
  //*Shows drop down for selecting type of book
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
  //*Shows an empty container with variable size for filling space in layout
  Widget _showEmptyContainer(int exp){
    return Expanded(
      flex: exp,
      child: Container(),
    );
  }
  //*Shows a trailing container with fixed size to be placed at the bottom to move submit button to be above floating action button from landing page
  Widget _showTrailingContainer(){
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }

  //*Future function to get image from camera when tapping image box
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  //*Creates list of dropdown menu items from the CategoryEnumMap
  List<DropdownMenuItem<Categories>> getCategoriesList(){
    List<DropdownMenuItem<Categories>> cats = <DropdownMenuItem<Categories>>[];
    for(int i = 1; i < Categories.values.length; i++){
      cats.add(new DropdownMenuItem(
        value: Categories.values[i],
        child: new Text(CategoryEnumMap[Categories.values[i]], textAlign: TextAlign.center,),
      ));
    }
    return cats;
  }
  //*Creates list of dropdown menu items from the PlatformEnumMap
  List<DropdownMenuItem<Platform>> getPlatformList(){
    List<DropdownMenuItem<Platform>> plats = <DropdownMenuItem<Platform>>[];
    for(final p in Platform.values){
      plats.add(new DropdownMenuItem(
        value: p,
        child: new Text(PlatformEnumMap[p]),
      ));
    }
    return plats;
  }
  //*Creates list of dropdown menu items from the CaseEnumMap
  List<DropdownMenuItem<Case>> getCaseList(){
    List<DropdownMenuItem<Case>> cases = <DropdownMenuItem<Case>>[];
    for(final c in Case.values){
      cases.add(new DropdownMenuItem(
        value: c,
        child: new Text(CaseEnumMap[c]),
      ));
    }
    return cases;
  }
  //*Creates list of dropdown menu items from the CompleteStatusEnumMap
  List<DropdownMenuItem<CompleteStatus>> getCompleteList(){
    List<DropdownMenuItem<CompleteStatus>> comps = <DropdownMenuItem<CompleteStatus>>[];
    for(final c in CompleteStatus.values){
      comps.add(new DropdownMenuItem(
        value: c,
        child: new Text(CompleteStatusEnumMap[c]),
      ));
    }
    return comps; 
  }
  //*Creates list of dropdown menu items from the BookTyoeEnumMap
  List<DropdownMenuItem<BookType>> getBookList(){
    List<DropdownMenuItem<BookType>> books = <DropdownMenuItem<BookType>>[];
    for(final b in BookType.values){
      books.add(new DropdownMenuItem(
        value: b,
        child: new Text(BookTypeEnumMap[b]),
      ));
    }
    return books;
  }

  /**
   * *Function of submit button
   * *Validates that there is a name (minimum data for an item)
   * *If there is an image, it encodes the file as a base64 string to be stored in a smaller size than a file object
   * *If validated it then checks the selected category and creates an appropriate item object
   * *Then adds that item to the collection, sorts the list, and pops the current page to return to the previous one
   */
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
            i = new Console(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, platform: _plat);
            break;
          case Categories.CONSOLE_ACCESSORY:
            i = new ConsoleAccessory(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, platform: _plat);
            break;
          case Categories.BOOK:
            i = new Book(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, bookType: _book, series: _series);
            break;
          case Categories.FIGURE:
            i = new Figure(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, series: _series);
            break;
          case Categories.COLLECTORS_EDITION:
            i = new CollectorsEdition(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, platform: _plat);
            break;
          case Categories.CLOTHING:
            i = new Clothing(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, series: _series);
            break;
          case Categories.ACCESSORY:
            i = new Clothing(name: _name, category: _cat, picPath: imgPath, desc: _desc, price: _price, purchasedAt: _purchasedAt, series: _series);
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
  //*Validates and saves form information using _formkey
  bool _validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  /**
   * *Adds new item to collection
   * *Uses database handler object to add it to firebase
   * *Adds item to globals list
   * *Checks the length of the recently added queue and removes until less than 10 items, then adds item to the end
   */
  void _addNewItemToDatabase(Item i){
    _handler.addDatabaseItem(i);
    globals.items.add(i);
    while(globals.recentlyAdded.length >= 10) globals.recentlyAdded.removeFirst();
    globals.recentlyAdded.add(i);
  }
}