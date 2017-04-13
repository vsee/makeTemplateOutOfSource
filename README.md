# C++ Project Template

This c++ project template supports:

* Automatic detection of C++ sources in specified folders
* Multiple source folders
* Multiple corresponding target folders for object and dependency files
* Automatic rule generation for each target folder
* Creation of target folders when they don't exist
* Dependency management with gcc : Build only what is necessary
* Works on Unix and DOS systems
* Written for GNU Make

All the credit goes to [TimF](http://stackoverflow.com/users/6413048/timf). See detailed explanation
in [this post](http://stackoverflow.com/a/39033569).

I adapted the original answer a bit and added the following features:

* Separate header files in include folder
* Source directory root can hold source files
* Application binary is build in binary folder
* Binary and Build folder are removed upon clean
