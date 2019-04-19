import 'package:firebase_database/firebase_database.dart';

import 'models/steam_item.dart';
import 'models/item.dart';

List<SteamItem> steamGames = <SteamItem>[];
List<Item> items = <Item>[];

String userId;