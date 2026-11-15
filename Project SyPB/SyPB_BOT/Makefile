CXX ?= g++
CXXFLAGS = -m32 -O2 -std=gnu++11 -fPIC -fvisibility=default -w \
           -I./include -I. -I.. -I../.. \
           -D__linux__ -Dlinux -D_GNU_SOURCE -DPLATFORM_LINUX32

LDFLAGS = -m32 -shared -fPIC -ldl -lm

SRCS = source/basecode.cpp \
       source/chatlib.cpp \
       source/combat.cpp \
       source/control.cpp \
       source/engine.cpp \
       source/Experience.cpp \
       source/globals.cpp \
       source/interface.cpp \
       source/navigate.cpp \
       source/netmsg.cpp \
       source/support.cpp \
       source/waypoint.cpp

OBJS = $(SRCS:.cpp=.o)
TARGET = sypb_i386.so

all: $(TARGET)

$(TARGET): $(OBJS)
$(CXX) $(OBJS) $(LDFLAGS) -o $@

%.o: %.cpp
$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
rm -f $(OBJS) $(TARGET)

.PHONY: all clean
