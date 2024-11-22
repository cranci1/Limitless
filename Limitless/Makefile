TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = Limitless

Limitless_FILES = Limitless.m
Limitless_PUBLIC_HEADERS = Limitless.h
Limitless_INSTALL_PATH = /Library/Frameworks
Limitless_CFLAGS = -fobjc-arc
Limitless_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/framework.mk