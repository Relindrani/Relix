// *Enum for possible categories and a map to convert them to strings
enum Categories { ALL_ITEM, GAME, CONSOLE, CONSOLE_ACCESSORY, BOOK, FIGURE, COLLECTORS_EDITION, CLOTHING, ACCESSORY, OTHER }
const CategoryEnumMap = <Categories, dynamic>{
  Categories.ALL_ITEM: "All Item",
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

// *Base item class. contains definition of what every basic item is
class Item{
  Item({this.name, this.category, this.picPath, this.desc, this.price, this.purchasedAt});

  String key;

  String name;
  Categories category;
  String picPath;
  String desc;
  double price;
  String purchasedAt;

  //*Get Item object from json response
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

  //*Convert Item object to json
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
//*Returns corresponding enum value from string
T getEnumValueFromMap<T>(Map<T, dynamic> enumValue, dynamic source){
  if(source == null) return null;
  return enumValue.entries.singleWhere((entry) => entry.value == source).key;
}