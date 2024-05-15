# This file is part of MXE. See LICENSE.md for licensing information.
#
# DO NOT BUMP VERSION UNTIL ISSUES WITH 4.3+ IS RESOLVED!
#

PKG             := ffmpeg
$(PKG)_WEBSITE  := https://ffmpeg.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.9
$(PKG)_CHECKSUM := 4974d62e7507ba3b26fa5f30af8ee36825917ddb4a1ad4118277698c1c8818cf
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://ffmpeg.org/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc bzip2 lame libvpx theora vorbis x264 xvidcore yasm zlib aom x265

# DO NOT ADD fdk-aac OR openssl SUPPORT.
# Although they are free softwares, their licenses are not compatible with
# the GPL, and we'd like to enable GPL in our default ffmpeg build.
# See docs/index.html#potential-legal-issues

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ffmpeg.org/releases/' | \
    $(SED) -n 's,.*ffmpeg-\([0-9][^>]*\)\.tar.*,\1,p' | \
    grep -v 'alpha\|beta\|rc\|git' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        --cross-prefix='$(TARGET)'- \
        --enable-cross-compile \
        --arch=$(firstword $(subst -, ,$(TARGET))) \
        --target-os=mingw32 \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-static --enable-shared \
        --yasmexe='$(TARGET)-yasm' \
        --disable-debug \
        --disable-pthreads \
        --enable-w32threads \
        --disable-doc \
        --enable-avresample \
        --enable-gpl \
        --enable-version3 \
        --extra-libs='-mconsole' \
        --disable-avisynth \
        --disable-gnutls \
        --disable-libass \
        --disable-libbluray \
        --disable-libbs2b \
        --disable-libcaca \
        --enable-libmp3lame \
        --disable-libopencore-amrnb \
        --disable-libopencore-amrwb \
        --disable-libopus \
        --disable-libspeex \
        --enable-libtheora \
        --disable-libvidstab \
        --disable-libvo-amrwbenc \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
	--enable-libaom \
        --enable-libx265 \
        --enable-libxvid \
        --extra-ldflags="-fstack-protector" \
        $($(PKG)_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
