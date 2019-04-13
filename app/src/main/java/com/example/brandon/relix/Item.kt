package com.example.brandon.relix

class Item {

    enum class ItemType {
        Game,
        Console,
        Book,
        Figure,
        Accessory,
        Card,
        BoardGame
    }
    data class ItemAttributes(val name: String, val type: ItemType, val cost: Double, val desc: String)

    val ItemTypeEnumStrings: Array<String> = GetItemTypeEnumArray();
    val attributes: ItemAttributes = GetItem().attributes

    external fun GetItemTypeEnumArray(): Array<String>
    external fun GetItem(): Item

    companion object {
        init {
            System.loadLibrary("Item")
        }
    }
}