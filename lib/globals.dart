import 'dart:collection';
import 'models/item.dart';

//*Global variable declarations, data that needs to persist through entire lifecycle of app

List<Item> items = <Item>[];

Queue<Item> recentlyAdded = new Queue();
Queue<Item> recentlyViewed = new Queue();

String userId;