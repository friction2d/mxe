# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtdeclarative
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := 239b4c3c4cc49b174391445ad4b8320c11c8655300977955febd5dde69d33df4
$(PKG)_SUBDIR    = $(subst qtbase,qtdeclarative,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qtdeclarative,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qtdeclarative,$(qtbase_URL))
$(PKG)_DEPS     := cc qtbase qtimageformats qtsvg qtxmlpatterns
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) := qtbase qtsvg qtxmlpatterns

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
