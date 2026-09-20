# Installing Go Cafe on Linux

Go Cafe ships for Linux as one AppImage file. There is no installer and no
package. Nothing is written outside your home directory. Delete the file and
it is gone.

## Install

1. Download `GoCafe-<version>-x86_64.AppImage` from the
   [Releases page](https://github.com/go-cafe-app/app/releases).
2. Make it executable and run it:

   ```sh
   chmod +x GoCafe-*.AppImage
   ./GoCafe-*.AppImage
   ```

Most file managers can do the first step for you: Properties, then *Allow
executing file as program*. Then double-click it.

For a menu entry, put the file in `~/Applications` and use
[Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) or
[AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher). Go Cafe
does not need either to run.

## Updates

Go Cafe checks for a new version when it starts. When there is one, a card in
the corner shows what changed. Click **Install**: it downloads the new
AppImage, checks it against the published checksum, puts it in place of the
old file and restarts. The file keeps its name and its place. Click ✕ to put
the card away until the next launch, or **Skip this version** to not hear
about that version again.

**Settings → About → Version** shows which version you have and checks again
when you tap it.

If the file is somewhere you cannot write, or you run it unpacked, the card
links to the download page instead.

## If it doesn't start

### "dlopen(): error loading libfuse.so.2"

An AppImage mounts itself with FUSE 2, and several distributions no longer
install it by default.

```sh
sudo apt install libfuse2      # Ubuntu 22.04, Debian 12, Mint 21
sudo apt install libfuse2t64   # Ubuntu 24.04 and newer
sudo dnf install fuse-libs     # Fedora
sudo pacman -S fuse2           # Arch
```

FUSE 2 and FUSE 3 coexist. Installing one does not break the other.

To run without FUSE, unpack it to a temporary directory first:

```sh
./GoCafe-*.AppImage --appimage-extract-and-run
```

This starts a little slower and needs a few hundred MB free in `/tmp`.

### "version `GLIBC_2.xx' not found"

Your distribution is older than the one the release was built on. The build
needs glibc 2.35.

| Works | Too old |
| --- | --- |
| Ubuntu 22.04 and newer | Ubuntu 20.04 and older |
| Debian 12 (bookworm) and newer | Debian 11 (bullseye) and older |
| Fedora 36 and newer | RHEL, Rocky and Alma 8 |
| Linux Mint 21, Pop!_OS 22.04, Zorin 17 and newer | openSUSE Leap 15.x |
| Arch, Manjaro, EndeavourOS | |

There is no workaround short of building it on your own machine. See
[Building it yourself](#building-it-yourself).

### A missing GTK or audio library

The AppImage does not bundle GTK 3, OpenGL, X11 or the sound stack. Those
have to come from your machine, and every mainstream desktop has them. On a
minimal install you may need:

```sh
sudo apt install libgtk-3-0 libasound2
```

### Anything else

Run it from a terminal and read what it prints:

```sh
./GoCafe-*.AppImage
```

On Wayland, if the window misbehaves, force X11:

```sh
GDK_BACKEND=x11 ./GoCafe-*.AppImage
```

## Where Go Cafe keeps things

- Settings, board choice and logs: `~/.local/share/app.gocafe.gocafe/`
- Cached data: `~/.cache/app.gocafe.gocafe/`
- Server passwords: your desktop keyring, through libsecret, where GNOME, KDE
  and most browsers keep theirs.

Both directories follow `XDG_DATA_HOME` and `XDG_CACHE_HOME` if you set them.

Without a keyring daemon, as on a bare window manager or a minimal install, Go
Cafe cannot save your login and asks for it every time. Installing and
unlocking `gnome-keyring` fixes that.

## Verifying the download

Each release has a `.sha256` file next to the AppImage:

```sh
sha256sum -c GoCafe-<version>-x86_64.AppImage.sha256
```

The AppImage is not GPG-signed. The checksum is the check.

## Reporting a problem

Attach the session log, `~/.local/share/app.gocafe.gocafe/gocafe-session.log`.
It records the app's conversation with the Go server for the current session.
It does not contain your password.

## Uninstalling

Delete the file. If you made a menu entry, remove
`~/.local/share/applications/gocafe.desktop` too. To clear your settings,
delete `~/.local/share/app.gocafe.gocafe/` and `~/.cache/app.gocafe.gocafe/`.
Your saved login is in the keyring under `app.gocafe.gocafe`.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
