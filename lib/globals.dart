import 'dart:collection';
import 'models/steam_item.dart';
import 'models/item.dart';

List<SteamItem> steamGames = <SteamItem>[];
List<Item> items = <Item>[];

Queue<Item> recentlyAdded = new Queue();
Queue<Item> recentlyViewed = new Queue();

String userId;