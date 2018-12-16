/*
 * store.cpp
 *
 *  Created on: 2018年12月16日
 *      Author: Administrator
 */

#include <map>
#include "store.h"

static map<string,int> store;

int getIdentify(const string& identify,int* value){
	if (store.find(identify) == store.end()) {
		return 1;
	}
	*value =  store[identify];
	return 0;
}

void setIdentify(const string& identify,int value){
	store[identify] = value;
}
