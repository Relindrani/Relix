

#ifndef RELIX_ITEMLIST_H
#define RELIX_ITEMLIST_H

#include "Item.h"
#include "ItemTypes.h"

struct node{
    Item item;
    node *next;
};

class ItemList{
private:
    node *head, *tail;
public:
    ItemList();
    ~ItemList();

    void insert(Item);
};

#endif