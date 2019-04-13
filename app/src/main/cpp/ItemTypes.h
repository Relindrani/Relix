//
// Created by brandon on 7/24/2018.
//

#ifndef RELIX_ITEMTYPES_H
#define RELIX_ITEMTYPES_H

#include "Item.h"

////////////////
// Game Class //
////////////////
class Game : public Item {
private:
    struct GameAttributes : ItemAttributes{
        GameAttributes();
        GameAttributes(std::string,ItemType,double,std::string);
    };
public:
    Game();
    ~Game();

    void SetAtt();


};

///////////////////
// Console Class //
///////////////////
class Console : public Item {
public:
    Console();
    ~Console();

protected:
    struct ConsoleAttributes : ItemAttributes{

    };
};

////////////////
// Book Class //
////////////////
class Book : public Item {
public:
    Book();
    ~Book();

protected:
    struct BookAttributes : ItemAttributes{

    };
};


//////////////////
// Figure Class //
//////////////////
class Figure : public Item {
public:
    Figure();
    ~Figure();

protected:
    struct FigureAttributes : ItemAttributes{

    };
};

/////////////////////
// Accessory Class //
/////////////////////
class Accessory : public Item{
public:
    Accessory();
    ~Accessory();

protected:
    struct AccessoryAttributes : ItemAttributes{

    };
};

////////////////
// Card Class //
////////////////
class Card : public Item{
public:
    Card();
    ~Card();

protected:
    struct CardAttributes : ItemAttributes{

    };
};

/////////////////////
// BoardGame Class //
/////////////////////
class BoardGame : public Item{
public:
    BoardGame();
    ~BoardGame();

protected:
    struct BoardGameAttributes : ItemAttributes{

    };
};

#endif //RELIX_ITEMTYPES_H
