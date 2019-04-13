//
// Created by brandon on 7/23/2018.
//

#include "Test.h"
#include <jni.h>

int Test::add(int a, int b) {
    return a + b;
}

static Test *test = new Test();

extern "C"{
    JNIEXPORT jint Java_com_example_brandon_relix_MainActivity_add(JNIEnv, jobject, jint a, jint b){
        return (test->add(a,b));
    }
}