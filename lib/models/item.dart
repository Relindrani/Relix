class Item{
  final int appId;
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
  }

  /*Item.fromJson(Map jsonMap) :
    appId = jsonMap['response']['games'][0]['appid'],
    name = jsonMap['response']['games'][0]['name'],
    logoUrl = jsonMap['response']['games'][0]['img_logo_url'],
    iconUrl = jsonMap['response']['games'][0]['img_icon_url'];*/
}