#!/bin/bash
# Installs or updates Go Cafe on a Mac, from Terminal, in one line:
#
#     curl -fsSL https://raw.githubusercontent.com/go-cafe-app/app/main/install.sh | bash
#
# Published as install.sh at the root of the public repository (synced there by
# scripts/sync-public-docs.sh); this file is where it is written.
#
# Why this exists: a disk image that came down through a browser carries the
# quarantine mark, and macOS then refuses to open an app that is not notarised
# until the person finds the Open Anyway button in System Settings. A file that
# curl downloaded carries no such mark — Apple documents that — so an app
# installed this way opens with a double-click, first time, no dialog. After
# that the app keeps itself up to date.
#
# Options, for the curious:
#     bash install.sh --reinstall     # put the current version on again
#     bash install.sh --version 1.2.3 # a particular version
#     bash install.sh --no-open       # install, but leave it to be opened later
#     GOCAFE_INSTALL_DIR=~/Applications bash install.sh
#
# The whole script is one function called on the last line, so a download that
# breaks off part way through runs nothing at all.

install_gocafe() {
  set -euo pipefail

  local REPO="${GOCAFE_REPO:-go-cafe-app/app}"
  # Overridable so the script can be tried against a stand-in for the release
  # page, the same way the app's own updater can (Distribution.releases).
  local RELEASES="${GOCAFE_RELEASES:-https://github.com/$REPO/releases}"
  local APP="Go Cafe"
  local STEM="GoCafe"
  local WANT="" REINSTALL=0 OPEN=1
  while [ $# -gt 0 ]; do
    case "$1" in
      --reinstall) REINSTALL=1 ;;
      --no-open) OPEN=0 ;;
      --version) WANT="${2#v}"; shift ;;
      -h|--help) sed -n '2,22p' "${BASH_SOURCE[0]}"; return 0 ;;
      *) printf 'unknown option: %s\n' "$1" >&2; return 2 ;;
    esac
    shift
  done

  # ---------------------------------------------------------------- looks --
  # Colour only when there is a terminal to see it. Piped through `bash`, stdout
  # is still the terminal, so the ordinary case is the pretty one.
  local B='' D='' G='' R='' Y='' N=''
  if [ -t 1 ] && [ "${TERM:-dumb}" != dumb ]; then
    B=$'\033[1m' D=$'\033[2m' G=$'\033[32m' R=$'\033[31m' Y=$'\033[33m' N=$'\033[0m'
  fi
  step() { printf '%s→%s %s\n' "$D" "$N" "$*"; }
  ok()   { printf '%s✓%s %s\n' "$G" "$N" "$*"; }
  fail() { printf '%s✗ %s%s\n' "$R" "$*" "$N" >&2; return 1; }

  printf '\n%s☕ %s%s\n\n' "$B" "$APP" "$N"

  # ---------------------------------------------------------- the machine --
  [ "$(uname -s)" = Darwin ] || fail "This installer is for macOS. Downloads for other systems: $RELEASES/latest"
  local osv; osv="$(sw_vers -productVersion)"
  case "$osv" in
    10.[0-9].*|10.1[0-4]*|10.1[0-4]) fail "$APP needs macOS 10.15 or newer; this Mac has $osv." ;;
  esac
  for tool in curl hdiutil ditto shasum plutil; do
    command -v "$tool" >/dev/null || fail "'$tool' is missing, which should not happen on a Mac."
  done

  # Applications, or the user's own if the system folder is not writable.
  local DIR="${GOCAFE_INSTALL_DIR:-}"
  if [ -z "$DIR" ]; then
    if [ -w /Applications ]; then DIR=/Applications; else DIR="$HOME/Applications"; fi
  fi
  mkdir -p "$DIR"
  local DEST="$DIR/$APP.app"

  # --------------------------------------------------------- the version --
  local VERSION="$WANT"
  if [ -z "$VERSION" ]; then
    step "Finding the latest version"
    # GitHub answers /releases/latest with a redirect to /releases/tag/<tag>.
    # No API, no token, no JSON: the same link the download page uses.
    local final
    final="$(curl -fsSLI -o /dev/null -w '%{url_effective}' "$RELEASES/latest" 2>/dev/null)" \
      || fail "Couldn't reach $RELEASES. Are you online?"
    VERSION="${final##*/tag/v}"
    [ "$VERSION" != "$final" ] && [ -n "$VERSION" ] \
      || fail "Couldn't tell what the latest version is (got: $final)"
  fi

  local HAVE=""
  if [ -f "$DEST/Contents/Info.plist" ]; then
    HAVE="$(plutil -extract CFBundleShortVersionString raw -o - "$DEST/Contents/Info.plist" 2>/dev/null || true)"
  fi
  if [ "$HAVE" = "$VERSION" ] && [ "$REINSTALL" = 0 ]; then
    ok "$APP $VERSION is already installed in $DIR — nothing to do."
    printf '%s  (bash install.sh --reinstall puts it on again)%s\n\n' "$D" "$N"
    [ "$OPEN" = 1 ] && { open -a "$DEST" 2>/dev/null || true; }
    return 0
  fi
  if [ "$HAVE" = "$VERSION" ]; then
    step "Putting $APP $VERSION on again"
  elif [ -n "$HAVE" ]; then
    step "Updating $APP $HAVE → $VERSION"
  else
    step "Installing $APP $VERSION into $DIR"
  fi

  # ---------------------------------------------------------- download --
  local WORK; WORK="$(mktemp -d "${TMPDIR:-/tmp}/gocafe-install.XXXXXX")"
  local MNT="$WORK/image"
  # The paths travel as arguments: the trap fires after this function and its
  # locals are gone.
  cleanup() {
    hdiutil detach "$1" -quiet 2>/dev/null || hdiutil detach "$1" -force -quiet 2>/dev/null || true
    # The mount point can be busy for a moment after the detach returns.
    rm -rf "$2" 2>/dev/null || { sleep 1; rm -rf "$2" 2>/dev/null || true; }
  }
  trap "cleanup '$MNT' '$WORK'" EXIT

  local FILE="$STEM-$VERSION.dmg"
  local URL="$RELEASES/download/v$VERSION/$FILE"
  step "Downloading $FILE"
  # A progress bar when there is a terminal to draw it on, silence otherwise.
  if [ -t 1 ]; then
    curl -fL --retry 3 --progress-bar -o "$WORK/$FILE" "$URL" \
      || fail "The download failed: $URL"
  else
    curl -fsSL --retry 3 -o "$WORK/$FILE" "$URL" \
      || fail "The download failed: $URL"
  fi

  step "Checking it against the published checksum"
  local expect actual
  expect="$(curl -fsSL --retry 3 "$URL.sha256" 2>/dev/null | awk '{print $1}' || true)"
  actual="$(shasum -a 256 "$WORK/$FILE" | awk '{print $1}')"
  [ -n "$expect" ] || fail "No checksum is published for $VERSION, so this build is not going to be installed."
  [ "$actual" = "$expect" ] || fail "The download did not match its checksum. Nothing was installed — try again, and if it repeats, say so at $RELEASES."

  # A file curl wrote carries no quarantine mark. Said out loud, because it is
  # the entire point and it is worth knowing if that ever changes.
  if xattr -p com.apple.quarantine "$WORK/$FILE" >/dev/null 2>&1; then
    printf '%s  (the download was quarantined by this system — macOS may still ask about it)%s\n' "$Y" "$N"
  fi

  # ------------------------------------------------------------ install --
  step "Opening the image"
  mkdir -p "$MNT"
  hdiutil attach "$WORK/$FILE" -nobrowse -readonly -noverify -noautoopen -mountpoint "$MNT" -quiet \
    || fail "Couldn't open the disk image."
  local SRC=""
  for candidate in "$MNT"/*.app; do
    [ -d "$candidate" ] || continue
    [ -z "$SRC" ] || fail "The image holds more than one app, which is not expected."
    SRC="$candidate"
  done
  [ -n "$SRC" ] || fail "There is no app in the image."
  codesign --verify --strict "$SRC" 2>/dev/null \
    || fail "The app in the image did not pass its own signature check. Nothing was installed."

  # A running copy is asked to quit, politely, then given a moment.
  if pgrep -fq "$DEST/Contents/MacOS/" 2>/dev/null; then
    step "Closing the running $APP"
    osascript -e "tell application \"$DEST\" to quit" >/dev/null 2>&1 || true
    local i
    for i in 1 2 3 4 5 6 7 8 9 10; do
      pgrep -fq "$DEST/Contents/MacOS/" 2>/dev/null || break
      sleep 0.5
    done
  fi

  step "Installing into $DIR"
  # Copied in beside the old one and swapped by rename, so there is no moment
  # in which a half-copied app sits where the whole one was. ditto keeps the
  # bundle exactly as it is on the image; cp -R would not.
  local NEXT="$DIR/.$APP.app.installing" PREV="$DIR/.$APP.app.previous"
  rm -rf "$NEXT" "$PREV"
  ditto "$SRC" "$NEXT" || fail "Couldn't copy $APP into $DIR."
  if [ -d "$DEST" ]; then mv "$DEST" "$PREV"; fi
  mv "$NEXT" "$DEST"
  rm -rf "$PREV"
  hdiutil detach "$MNT" -quiet 2>/dev/null || true

  ok "$APP $VERSION is installed: $DEST"
  printf '%s  It opens with a double-click, no warning — and updates itself from here on.%s\n\n' "$D" "$N"
  [ "$OPEN" = 1 ] && { open -a "$DEST" || true; }
  return 0
}

install_gocafe "$@"
