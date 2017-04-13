# Set project directory to Makefile directory. $(CURDIR) is a GNU make variable containing the path to the current working directory
PROJDIR := $(realpath $(CURDIR))
SOURCEDIR := $(PROJDIR)/src
INCLUDEDIR := $(PROJDIR)/inc
BUILDDIR := $(PROJDIR)/bld
BINDIR := $(PROJDIR)/bin

# Name of the final executable
TARGETNAME = application
TARGET = $(BINDIR)/$(TARGETNAME)

# Decide whether the commands will be shwon or not
VERBOSE = TRUE

# Create the list of directories
DIRS = resourceLoader
SOURCEDIRS = $(foreach dir, $(DIRS), $(addprefix $(SOURCEDIR)/, $(dir)))
SOURCEDIRS += $(SOURCEDIR)
INCLUDEDIRS = $(foreach dir, $(DIRS), $(addprefix $(INCLUDEDIR)/, $(dir)))
INCLUDEDIRS += $(INCLUDEDIR)
TARGETDIRS = $(foreach dir, $(DIRS), $(addprefix $(BUILDDIR)/, $(dir)))
TARGETDIRS += $(BUILDDIR)

# Generate the GCC includes parameters by adding -I before each source folder
INCLUDES = $(foreach dir, $(INCLUDEDIRS), $(addprefix -I, $(dir)))

# Add this list to VPATH, the place make will look for the source files
VPATH = $(SOURCEDIRS)

# Create a list of *.cpp sources in DIRS
SOURCES = $(foreach dir,$(SOURCEDIRS),$(wildcard $(dir)/*.cpp))

# Define objects for all sources
OBJS := $(subst $(SOURCEDIR),$(BUILDDIR),$(SOURCES:.cpp=.o))

# Define dependencies files for all objects
DEPS = $(OBJS:.o=.d)

# Name the compiler
CC = g++

# OS specific part
ifeq ($(OS),Windows_NT)
	RM = del /F /Q 
	RMDIR = -RMDIR /S /Q
	MKDIR = -mkdir
	ERRIGNORE = 2>NUL || true
	SEP=\\
else
	RM = rm -rf 
	RMDIR = rm -rf 
	MKDIR = mkdir -p
	ERRIGNORE = 2>/dev/null
	SEP=/
endif

# Remove space after separator
PSEP = $(strip $(SEP))

# Hide or not the calls depending of VERBOSE
ifeq ($(VERBOSE),TRUE)
	HIDE =  
else
	HIDE = @
endif

# Define the function that will generate each rule
define generateRules
$(1)/%.o: %.cpp
	@echo Building $$@
	$(HIDE)$(CC) -c $$(INCLUDES) -o $$(subst /,$$(PSEP),$$@) $$(subst /,$$(PSEP),$$<) -MMD
endef

# Indicate to make which targets are not files
.PHONY: all clean directories 

all: directories $(TARGET)

$(TARGET): $(OBJS)
	$(HIDE)echo Linking $@
	$(HIDE)$(CC) $(OBJS) -o $(TARGET)

# Include dependencies
-include $(DEPS)

# Generate rules
$(foreach targetdir, $(TARGETDIRS), $(eval $(call generateRules, $(targetdir))))

directories: 
	$(HIDE)$(MKDIR) $(subst /,$(PSEP),$(TARGETDIRS)) $(ERRIGNORE)
	$(HIDE)$(MKDIR) $(BINDIR)

# Remove all objects, dependencies and executable files generated during the build
clean:
	$(HIDE)$(RMDIR) $(subst /,$(PSEP),$(TARGETDIRS)) $(ERRIGNORE)
	$(HIDE)$(RMDIR) $(BUILDDIR) $(ERRIGNORE)
	$(HIDE)$(RM) $(TARGET) $(ERRIGNORE)
	$(HIDE)$(RMDIR) $(BINDIR) $(ERRIGNORE)
	@echo Cleaning done ! 
