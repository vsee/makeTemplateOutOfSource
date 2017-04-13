/* 
 * File:   ResourceLoader.h
 * Author: vseeker
 *
 * Created on 08 April 2017, 12:51
 */

#ifndef RESOURCELOADER_H
#define	RESOURCELOADER_H

class ResourceLoader {
public:
    ResourceLoader();
    ResourceLoader(const ResourceLoader& orig);
    virtual ~ResourceLoader();

    void loadResources();
private:

};

#endif	/* RESOURCELOADER_H */

