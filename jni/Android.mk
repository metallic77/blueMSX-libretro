LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

GIT_VERSION := " $(shell git rev-parse --short HEAD || echo unknown)"
ifneq ($(GIT_VERSION)," unknown")
	LOCAL_CFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
endif

ifeq ($(TARGET_ARCH),arm)
LOCAL_CFLAGS += -DANDROID_ARM
LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
LOCAL_CFLAGS +=  -DANDROID_X86
endif

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS += -DANDROID_MIPS
endif

CORE_DIR := ..

LOCAL_MODULE    := libretro
HAVE_COMPAT := 1
SHARED := -shared -Wl,-version-script=link.T -Wl,-no-undefined

include ../Makefile.common

LOCAL_SRC_FILES    =  $(SOURCES_CXX) $(SOURCES_C)

CORE_FLAGS    := $(COREDEFINES) $(INCFLAGS)
LOCAL_CXXFLAGS = -DANDROID $(CORE_FLAGS) $(INCFLAGS)
LOCAL_CFLAGS += -DANDROID $(CORE_FLAGS) $(INCFLAGS)
LOCAL_C_INCLUDES = $(INCFLAGS)
LOCAL_LDLIBS += -lz

include $(BUILD_SHARED_LIBRARY)
