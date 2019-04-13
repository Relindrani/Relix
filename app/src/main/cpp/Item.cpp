//
// Created by brandon on 7/24/2018.
//

#include "Item.h"

#include <jni.h>

Item::Item(){
    
}

Item::~Item(){

}

extern "C"{
    JNIEXPORT jobjectArray JNICALL Java_com_example_brandon_relix_MainActivity_GetItemTypeEnumArray(JNIEnv *env,jobject){
        jobjectArray types;
        int size = sizeof(ItemTypeEnumStrings)/ sizeof(ItemTypeEnumStrings[0]);

        types = (jobjectArray)env->NewObjectArray(size,env->FindClass("java/lang/String"),env->NewStringUTF(""));

        for(int i=0;i<size;i++)env->SetObjectArrayElement(types,i,env->NewStringUTF(ItemTypeEnumStrings[i]));

        return types;
    }
    JNIEXPORT jobject JNICALL Java_com_example_brandon_relix_Item_GetItem(JNIEnv *env, jobject){
        jclass item = env->FindClass("com/example/brandon/relix/Item");
        jmethodID methodID = env->GetMethodID(item, "<init>","(I)V");
        jobject obj = env->NewObject(item,methodID);

        return obj;
    }
}