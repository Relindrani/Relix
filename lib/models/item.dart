
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
  /*final int appId;
  final String name;
  final String logoUrl;
  final String iconUrl;

  Item({this.appId, this.name, this.logoUrl, this.iconUrl});

  factory Item.fromJson(Map json){
    return Item(
      /*appId : json['response']['games'][0]['appid'],
      name : json['response']['games'][0]['name'],
      logoUrl : json['response']['games'][0]['img_logo_url'],
      iconUrl : json['response']['games'][0]['img_icon_url']*/
      appId : json['appid'],
      name : json['name'],
      logoUrl : json['img_logo_url'],
      iconUrl : json['img_icon_url']
    );
  }*/
}