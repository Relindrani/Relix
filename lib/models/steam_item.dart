import 'itemTypes.dart';
import 'item.dart';

class SteamItem{
  final int appId;
  final String name;
  final String logoUrl;
  final String iconUrl;

  SteamItem({this.appId, this.name, this.logoUrl, this.iconUrl});

  factory SteamItem.fromJson(Map json){
    return SteamItem(
      appId : json['appid'],
      name : json['name'],
      logoUrl : json['img_logo_url'],
      iconUrl : json['img_icon_url']
    );
  }
}

/**
 * ?Don't extend Game
 * ?Leave as separate item then create new Game from this
 * ?Store this in database and keep list of Steam items
 * ?Compare app id to existing list each time api is called to prevent duplicates
 */