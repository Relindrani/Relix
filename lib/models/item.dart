import 'package:firebase_database/firebase_database.dart';

enum Categories { ALL_ITEM, GAME, CONSOLE, CONSOLE_ACCESSORY, BOOK, FIGURE, COLLECTORS_EDITION, CLOTHING, ACCESSORY, OTHER }
const CategoryEnumMap = <Categories, dynamic>{
  Categories.ALL_ITEM: Null,
  Categories.GAME: "Game",
  Categories.CONSOLE: "Console",
  Categories.CONSOLE_ACCESSORY: "Console Accessory",
  Categories.BOOK: "Book",
  Categories.FIGURE: "Figure",
  Categories.COLLECTORS_EDITION: "Collector's Edition",
  Categories.CLOTHING: "Clothing",
  Categories.ACCESSORY: "Accessory",
  Categories.OTHER: "Other Item"
};

class Item{

  Item({this.name, this.category, this.picPath, this.desc, this.price, this.purchasedAt});

  String key;

  String name;
  Categories category;
  String picPath;
  String desc;
  double price;
  String purchasedAt;

  /*Item.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    name = snapshot.value['name'],
    category = snapshot.value['category'],
    picPath = snapshot.value['picPath'],
    desc = snapshot.value['description'],
    price = snapshot.value['price'],
    purchasedAt = snapshot.value['purchasedAt'];*/

  factory Item.fromJson(Map json){
    return Item(
      name: json['name'], 
      category: getEnumValueFromMap(CategoryEnumMap, json['category']), 
      picPath: json['picPath'], 
      desc: json['description'], 
      price: json['price'], 
      purchasedAt: json['purchasedAt']
    );
  }

  Map toJson(){
    return{
      'name': name,
      'category': CategoryEnumMap[category],
      'picPath': picPath,
      'description': desc,
      'price': price,
      'purchasedAt': purchasedAt,
    };
  }
}

T getEnumValueFromMap<T>(Map<T, dynamic> enumValue, dynamic source){
  if(source == null)return null;
  return enumValue.entries.singleWhere((entry) => entry.value == source).key;
}