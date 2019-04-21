//*Steam item class. independant object class for getting and handling data from steam api
class SteamItem{
  final int appId;
  final String name;
  final String logoUrl;
  final String iconUrl;

  SteamItem({this.appId, this.name, this.logoUrl, this.iconUrl});

  //*Get SteamItem object from json response
  factory SteamItem.fromJson(Map json){
    return SteamItem(
      appId : json['appid'],
      name : json['name'],
      logoUrl : json['img_logo_url'],
      iconUrl : json['img_icon_url']
    );
  }
}