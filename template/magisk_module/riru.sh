#!/sbin/sh
RIRU_PATH="/data/adb/riru"
RIRU_MODULE_ID="%%%RIRU_MODULE_ID%%%"
RIRU_MODULE_PATH="$RIRU_PATH/modules/$RIRU_MODULE_ID"
RIRU_SECONTEXT="u:object_r:magisk_file:s0"

abort_clean() {
  rm -rf "$MODPATH"
  abort "$1"
}

check_riru_version() {
  RIRU_MIN_API_VERSION=%%%RIRU_MIN_API_VERSION%%%
  RIRU_MIN_VERSION_NAME="%%%RIRU_MIN_VERSION_NAME%%%"

  ui_print "check_riru_version"
  if [ ! -f "$RIRU_PATH/api_version" ]; then
    ui_print "*********************************************************"
    ui_print "! Riru $RIRU_MIN_VERSION_NAME or above is required"
    ui_print "! Please download 'Riru - Core' from 'Magisk Manager' or https://github.com/RikkaApps/Riru/releases"
    abort_clean "*********************************************************"
  fi
  RIRU_API_VERSION=$(cat "$RIRU_PATH/api_version")
  ui_print "- Riru API version: $RIRU_API_VERSION"
  if [ "$RIRU_API_VERSION" -lt $RIRU_MIN_API_VERSION ]; then
    ui_print "*********************************************************"
    ui_print "! The latest version of Riru is required"
    ui_print "! Please download 'Riru - Core' from 'Magisk Manager' or https://github.com/RikkaApps/Riru/releases"
    abort_clean "*********************************************************"
  fi
}

check_architecture() {
  if [ "$ARCH" != "arm" ] && [ "$ARCH" != "arm64" ] && [ "$ARCH" != "x86" ] && [ "$ARCH" != "x64" ]; then
    abort_clean "! Unsupported platform: $ARCH"
  else
    ui_print "- Device platform: $ARCH"
  fi
}
