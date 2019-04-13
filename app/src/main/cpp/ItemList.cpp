

#include "ItemList.h"

ItemList::ItemList(){
    head = NULL;
    tail = NULL;
}

ItemList::~ItemList(){

}

void ItemList::insert(Item newItem){
    node *temp = new node; 
    temp->item = newItem;
    temp->next = NULL;
    if(head == NULL){
        head = temp;
        tail = temp;
        temp = NULL;
    }else{
        tail->next = temp;
        tail = temp;
    }
}