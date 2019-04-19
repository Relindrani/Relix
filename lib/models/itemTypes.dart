import 'package:firebase_database/firebase_database.dart';

import 'item.dart';

enum Platform { PC, PS4, PS3, PS2, PS1, XBOX_ONE, XBOX_360, XBOX, SWITCH, WII_U, WII, GAMECUBE, OTHER}
enum Case { NO_CASE, REGULAR_CASE, STEELBOOK }
enum CompleteStatus { NOT_PLAYED, STARTED, FINISHED, COMPLETED }
enum BookType { STRATEGY, ART, COMPENDIUM, OTHER }

const PlatformEnumMap = <Platform, dynamic>{
  Platform.PC: "PC",
  Platform.PS4: "PS4",
  Platform.PS3: "PS3",
  Platform.PS2: "PS2",
  Platform.PS1: "PS1",
  Platform.XBOX_ONE: "XBOX One",
  Platform.XBOX_360: "XBOX 360",
  Platform.XBOX: "XBOX",
  Platform.SWITCH: "Switch",
  Platform.WII_U: "WII U",
  Platform.WII: "WII",
  Platform.GAMECUBE: "GameCube",
  Platform.OTHER: "Other"
};
const CaseEnumMap = <Case, dynamic>{
  Case.NO_CASE: "No Case",
  Case.REGULAR_CASE: "Regular Case",
  Case.STEELBOOK: "Steelbook"
};
const CompleteStatusEnumMap = <CompleteStatus, dynamic>{
  CompleteStatus.NOT_PLAYED: "Not Played",
  CompleteStatus.STARTED: "Started",
  CompleteStatus.FINISHED: "Finished",
  CompleteStatus.COMPLETED: "Completed"
};
const BookTypeEnumMap = <BookType, dynamic>{
  BookType.STRATEGY: "Strategy",
  BookType.ART: "Art",
  BookType.COMPENDIUM: "Compendium",
  BookType.OTHER: "Other"
};

class Game extends Item{
  
  Game({String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.platform, this.isSteamGame, this.isDigital, this.caseType, this.series, this.complete}) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  Platform platform;
  bool isSteamGame;
  bool isDigital;
  Case caseType;
  String series;
  CompleteStatus complete;

  /*Game.fromSnapshot(DataSnapshot snapshot) : 
    platform = snapshot.value['platform'],
    isSteamGame = snapshot.value['isSteamGame'],
    isDigital = snapshot.value['isDigital'],
    caseType = snapshot.value['caseType'],
    series = snapshot.value['series'],
    complete = snapshot.value['complete'],
    super.fromSnapshot(snapshot);*/

  factory Game.fromJson(Map json){
    return Game(
      name: json['name'], 
      category: getEnumValueFromMap(CategoryEnumMap, json['category']), 
      picPath: json['picPath'], 
      desc: json['description'], 
      price: json['price'], 
      purchasedAt: json['purchasedAt'],
      platform: getEnumValueFromMap(PlatformEnumMap, json['platform']),
      isSteamGame: json['isSteamGame'],
      isDigital: json['isDigital'],
      caseType: getEnumValueFromMap(CaseEnumMap, json['caseType']),
      series: json['series'],
      complete: getEnumValueFromMap(CompleteStatusEnumMap, json['complete'])
    );
  }

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'platform': PlatformEnumMap[platform],
      'isSteamGame': isSteamGame,
      'isDigital': isDigital,
      'caseType': CaseEnumMap[caseType],
      'series': series,
      'complete': CompleteStatusEnumMap[complete],
    };
  }
}

class Console extends Item{
  
  Console(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.platform) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  Platform platform;

  /*Console.fromSnapshot(DataSnapshot snapshot) : 
    platform = snapshot.value['platform'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'platform': PlatformEnumMap[platform],
    };
  }
}

class ConsoleAccessory extends Item{
  
  ConsoleAccessory(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.platform) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  Platform platform;

  /*ConsoleAccessory.fromSnapshot(DataSnapshot snapshot) : 
    platform = snapshot.value['platform'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'platform': PlatformEnumMap[platform],
    };
  }
}

class Book extends Item{
  
  Book(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.bookType, this.series) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  BookType bookType;
  String series;

  /*Book.fromSnapshot(DataSnapshot snapshot) : 
    bookType = snapshot.value['bookType'],
    series = snapshot.value['series'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'bookType': BookTypeEnumMap[bookType],
      'series': series,
    };
  }
}

class Figure extends Item{
 
  Figure(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.series) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  String series;

  /*Figure.fromSnapshot(DataSnapshot snapshot) : 
    series = snapshot.value['series'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'series': series,
    };
  }
}

class CollectorsEdition extends Item{

  CollectorsEdition(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.platform) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  Platform platform;
  String series;

  /*CollectorsEdition.fromSnapshot(DataSnapshot snapshot) : 
    platform = snapshot.value['platform'],
    series = snapshot.value['series'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'platform': PlatformEnumMap[platform],
      'series': series,
    };
  }
}

class Clothing extends Item{

  Clothing(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.series) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  String series;

  /*Clothing.fromSnapshot(DataSnapshot snapshot) : 
    series = snapshot.value['series'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'series': series,
    };
  }
}

class Accessory extends Item{

  Accessory(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this.series) : super(name: name, category: category, picPath: picPath, desc: desc, price: price, purchasedAt: purchasedAt);

  String series;

  /*Accessory.fromSnapshot(DataSnapshot snapshot) : 
    series = snapshot.value['series'],
    super.fromSnapshot(snapshot);*/

  @override
  Map toJson() {
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
      'series': series,
    };
  }
}