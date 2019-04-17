import 'item.dart';

enum Platform { PC, PS4, PS3, PS2, PS1, XBOX_ONE, XBOX_360, XBOX, SWITCH, WII_U, WII, GAMECUBE, OTHER}
enum Case { NO_CASE, REGULAR_CASE, STEELBOOK }
enum CompleteStatus { NOT_PLAYED, STARTED, FINISHED, COMPLETED }

class Game extends Item{
  
  Game(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._platform, this._isSteamGame, this._isDigital, this._caseType, this._series, this._complete) : super(name, category, picPath, desc, price,purchasedAt);

  Platform _platform;
  bool _isSteamGame;
  bool _isDigital;
  Case _caseType;
  String _series;
  CompleteStatus _complete;

  Platform get platform => _platform;
  set platform(Platform p) => _platform = p;

  bool get isSteamGame => _isSteamGame;
  set isSteamGame(bool b) => _isSteamGame = b;

  bool get isDigital => _isDigital;
  set isDigital(bool b) => _isDigital = b;

  Case get caseType => _caseType;
  set caseType(Case c) => _caseType = c;

  String get series => _series;
  set series(String s) => _series = s;

  CompleteStatus get complete => _complete;
  set complete(CompleteStatus c) => _complete = c;
}

class Console extends Item{
  
  Console(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._platform) : super(name, category, picPath, desc, price, purchasedAt);

  Platform _platform;

  Platform get platform => _platform;
  set platform(Platform p) => _platform = p;
}

class ConsoleAccessory extends Item{
  
  ConsoleAccessory(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._platform) : super(name, category, picPath, desc, price, purchasedAt);

  Platform _platform;

  Platform get platform => _platform;
  set platform(Platform p) => _platform = p;
}

enum BookType { STRATEGY, ART, COMPENDIUM, OTHER }

class Book extends Item{
  
  Book(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._bookType, this._series) : super(name, category, picPath, desc, price, purchasedAt);

  BookType _bookType;
  String _series;

  BookType get bookType => _bookType;
  set bookType(BookType b) => _bookType = b;

  String get series => _series;
  set series(String s) => _series = s;
}

class Figure extends Item{
 
  Figure(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._series) : super(name, category, picPath, desc, price, purchasedAt);

  String _series;

  String get series => _series;
  set series(String s) => _series = s;
}

class CollectorsEdition extends Item{

  CollectorsEdition(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._platform) : super(name, category, picPath, desc, price, purchasedAt);

  Platform _platform;
  String _series;

  Platform get platform => _platform;
  set platform(Platform p) => _platform = p;

  String get series => _series;
  set series(String s) => _series = s;
}

class Clothing extends Item{

  Clothing(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._series) : super(name, category, picPath, desc, price, purchasedAt);

  String _series;

  String get series => _series;
  set series(String s) => _series = s;
}

class Accessory extends Item{

  Accessory(String name, Categories category, String picPath, String desc, double price, String purchasedAt, this._series) : super(name, category, picPath, desc, price, purchasedAt);

  String _series;

  String get series => _series;
  set series(String s) => _series = s;
}