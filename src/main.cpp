#include <iostream>

#include "ResourceLoader.h"

using namespace std;

int main() {
    cout << "Hello Main" << endl;
    
    ResourceLoader res;
    res.loadResources();

    cout << "Bye Main" << endl;
    return 0;
}
