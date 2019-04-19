import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import 'dart:convert';

import '../models/item.dart';
import '../models/itemTypes.dart';

import 'image_viewer.dart';

class ItemPage extends StatelessWidget{

  final dynamic i;
  ItemPage(this.i);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(i.name),
      ),
      body: Center(
        child: _showBody(context),
      ),
    );
  }

  Widget _showBody(BuildContext context){
    switch(i.category){
      case Categories.GAME:
        return _showGameBody(context);
        break;
      case Categories.CONSOLE:
        return _showConsoleBody(context);
        break;
      case Categories.CONSOLE_ACCESSORY:
        return _showConsoleAccessoryBody(context);
        break;
      case Categories.BOOK:
        return _showBookBody(context);
        break;
      case Categories.FIGURE:
        return _showFigureBody(context);
        break;
      case Categories.COLLECTORS_EDITION:
        return _showCollectorsEditionBody(context);
        break;
      case Categories.CLOTHING:
        return _showClothingBody(context);
        break;
      case Categories.ACCESSORY:
        return _showAccessoryBody(context);
        break;
      default:
        return _showDefaultBody(context);
    }
  }

  Widget _showDefaultBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           _showTags(),
          _showImage(context),
          _showDescription(),
          _showPurchaseInformation(),
        ],
      ),
    );
  }
  Widget _showGameBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation(),
          _showCompleteStatus(),
        ],
      ),
    );
  }
  Widget _showConsoleBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showConsoleAccessoryBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showBookBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showFigureBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showCollectorsEditionBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showClothingBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation()
        ],
      ),
    );
  }
  Widget _showAccessoryBody(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showTags(),
          _showImage(context),
          _showDescription(),
          _showSeries(),
          _showPurchaseInformation()
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context){
    return Expanded(
      flex: 9,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: (i.picPath != null && i.picPath != "") ? InkWell(
          child: Container(
            child: SizedBox.expand(
              child: (i is Game && i.isSteamGame) ? Image.network(i.picPath, fit: BoxFit.fitWidth,) : Image.memory(base64.decode(i.picPath), fit: BoxFit.fitWidth,),
            )   
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewer(i.picPath,(i is Game && i.isSteamGame)))),
        ) : Center(
          child: Text("No Image"),
        ),
      ),
    );
  }

  Widget _showTags(){
    switch (i.category){
      case Categories.GAME:
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _showCategory(),
            ),
            Expanded(
              flex: 1,
              child: _showPlatform(),
            ),
            Expanded(
              flex: 1,
              child: _showDigital(),
            ),
            Expanded(
              flex: 1,
              child: _showCaseType(),
            )
          ],
        );
      case Categories.CONSOLE : case Categories.CONSOLE_ACCESSORY: case Categories.COLLECTORS_EDITION:
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _showCategory(),
            ),
            Expanded(
              flex: 1,
              child: _showPlatform(),
            )
          ],
        );
      case Categories.BOOK:
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _showCategory(),
            ),
            Expanded(
              flex: 1,
              child: _showBookType(),
            )
          ],
        );
      default:
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _showCategory(),
            )
          ],
        );
    }
  }
  Widget _showCategory(){
    return Container(
      child: Text(
        'Category:\n' + formatCategoriesText(i.category.toString()), 
        textAlign: TextAlign.center, 
      ),
    );
  }
  Widget _showPlatform(){
    return Container(
      child: Text(
        'Platform:\n' + formatPlatformText(i.platform.toString()),
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget _showCaseType(){
    return Container(
      child: Text(
        'Case:\n' + formatCategoriesText(i.caseType.toString()),
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget _showBookType(){
    return Container(
      child: Text(
        'Book Type:\n' + formatCategoriesText(i.bookType.toString()),
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget _showDigital(){
    return Container(
      child: Text(
        'Format:\n' + ((i.isDigital) ? "Digital" : "Physical"),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _showDescription(){
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text('Description: '),
          ),
          Expanded(
            flex: 3,
            child: Text(i.desc),
          )
        ],
      )
    );
  }
  Widget _showPurchaseInformation(){
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          _showPrice(),
          _showPurchasedAt()
        ],
      ),
    );
  }
  Widget _showPrice(){
    return Expanded(
      flex: 2,
      child: Text('Price: \$' + i.price.toString()),
    );
  }
  Widget _showPurchasedAt(){
    return Expanded(
      flex: 2,
      child: Text('Purchased From: ' + i.purchasedAt),
    );
  }
  Widget _showSeries(){
    return Expanded(
      flex: 2,
      child: Text('Series: ' + i.series),
    );
  }
  Widget _showCompleteStatus(){
    return Expanded(
      flex: 2,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(formatCategoriesText(i.complete.toString())),
          ),
          Padding(padding: EdgeInsets.all(5.0),),
          Expanded(
            flex: 5,
            child: _showCompleteBar()
          )
        ],
      ),
    );
  }
  Widget _showCompleteBar(){
    switch (i.complete){
      case CompleteStatus.STARTED:
        return LinearProgressIndicator(
          value: 0.33,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        );
      case CompleteStatus.FINISHED:
        return LinearProgressIndicator(
          value: 0.66,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow)
        );
      case CompleteStatus.COMPLETED:
        return LinearProgressIndicator(
          value: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green)
        );
      default:
        return LinearProgressIndicator(
          value: 0.0,
        );
    }
  }

  Widget _showEmptyContainer(int exp){
    return Expanded(
      flex: exp,
      child: Container(),
    );
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
}