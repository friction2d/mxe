JOBS := 4
MXE_TARGETS := x86_64-w64-mingw32.static
LOCAL_PKG_LIST := ffmpeg
.DEFAULT_GOAL := local-pkg-list
local-pkg-list: $(LOCAL_PKG_LIST)

