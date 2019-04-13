//
// Created by brandon on 7/24/2018.
//

#include "Item.h"
#include "ItemTypes.h"

////////////////
// Game Class //
////////////////
Game::Game(){
    GameAttributes *att = new GameAttributes("",ItemType::Game,0,"");
    attributes = att;
}
Game::~Game() {

}

///////////////////
// Console Class //
///////////////////
Console::Console() {

}
Console::~Console() {

}

////////////////
// Book Class //
////////////////
Book::Book() {

}
Book::~Book() {

}

//////////////////
// Figure Class //
//////////////////
Figure::Figure() {

}
Figure::~Figure(){

}

/////////////////////
// Accessory Class //
/////////////////////
Accessory::Accessory() {

}
Accessory::~Accessory() {

}

////////////////
// Card Class //
////////////////
Card::Card(){

}
Card::~Card(){

}

/////////////////////
// BoardGame Class //
/////////////////////
BoardGame::BoardGame() {

}
BoardGame::~BoardGame() {

}