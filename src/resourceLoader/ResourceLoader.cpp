/* 
 * File:   ResourceLoader.cpp
 * Author: vseeker
 * 
 * Created on 08 April 2017, 12:51
 */

#include <iostream>
#include "ResourceLoader.h"


ResourceLoader::ResourceLoader() {
}

ResourceLoader::ResourceLoader(const ResourceLoader& orig) {
}

ResourceLoader::~ResourceLoader() {
}

void ResourceLoader::loadResources() {
	std::cout << "Loading lots of resources ..." << std::endl;
}
