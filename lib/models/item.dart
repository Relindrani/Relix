
enum Categories { GAME, CONSOLE, CONSOLE_ACCESSORY, BOOK, FIGURE, COLLECTORS_EDITION, CLOTHING, ACCESSORY, OTHER }

class Item{

  Item(this._name, this._category, this._picPath, this._desc, this._price, this._purchasedAt);

  String _name;
  Categories _category;
  String _picPath;
  String _desc;
  double _price;
  String _purchasedAt;

  String get name => _name;
  set name(String n) => _name = n;

  Categories get category => _category;
  set category(Categories c) => _category = c;

  String get picPath => _picPath;
  set picPath(String s) => _picPath = s;

  String get desc => _desc;
  set desc(String s) => _desc = s;

  double get price => _price;
  set price(double d) => _price = d;

  String get purchasedAt => _purchasedAt;
  set purchasedAt(String s) => _purchasedAt = s;
}