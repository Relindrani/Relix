//
// Created by brandon on 7/24/2018.
//

#ifndef RELIX_ITEM_H
#define RELIX_ITEM_H

#include <iostream>

//* Different types of items
enum ItemType{
    Game,
    Console,
    Book,
    Figure,
    Accessory,
    Card,
    BoardGame,
    Other
};

//* String array for types of items
static const char* ItemTypeEnumStrings[] = {"Game", "Console", "Book", "Figure", "Accessory", "Card", "Board Game", "Other"};

struct ItemAttributes{
    std::string name;
    ItemType type;
    double cost;
    std::string desc;
};

class Item{
public:
    Item();
    ~Item();

    //virtual void SetAttributes(std::string,ItemType,double,std::string);

    //virtual ItemAttributes GetAttributes(){ return NULL; }
protected:
    ItemAttributes* attributes;
};

#endif //RELIX_ITEM_H
