# Installing Go Cafe on Linux

Go Cafe ships for Linux as a single **AppImage** — one file, no installer, no
package manager, nothing written outside your home directory. Delete the file
and it's gone.

## Install

1. Download `GoCafe-<version>-x86_64.AppImage` from the
   [Releases page](https://github.com/go-cafe-app/app/releases).
2. Make it executable and run it:

   ```sh
   chmod +x GoCafe-*.AppImage
   ./GoCafe-*.AppImage
   ```

That's it. Most desktops will also let you tick *Allow executing file as
program* in the file manager's Properties dialog instead of running `chmod`, and
then launch it by double-clicking.

If you want it in your applications menu, drop it in `~/Applications` and
install [Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) or
[AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher), which
handle menu entries and updates for AppImages generally. Go Cafe doesn't need
either one to run.

## If it doesn't start

### "dlopen(): error loading libfuse.so.2"

This is the common one. An AppImage mounts itself with FUSE 2, and several
distributions stopped installing FUSE 2 by default once they moved to FUSE 3.

```sh
sudo apt install libfuse2      # Ubuntu 22.04, Debian 12, Mint 21
sudo apt install libfuse2t64   # Ubuntu 24.04 and newer
sudo dnf install fuse-libs     # Fedora
sudo pacman -S fuse2           # Arch
```

Installing `libfuse2` alongside `fuse3` is fine — they coexist, and nothing
already on your system breaks.

If you'd rather not install anything, this runs the app without FUSE by
unpacking it to a temporary directory first:

```sh
./GoCafe-*.AppImage --appimage-extract-and-run
```

It's a little slower to start and needs a few hundred MB of free space in
`/tmp`, but it is otherwise identical.

### "version `GLIBC_2.xx' not found"

Your distribution is older than the one the release was built on. The build
targets **glibc 2.35**, so the AppImage runs on:

| Works | Too old |
| --- | --- |
| Ubuntu 22.04 and newer | Ubuntu 20.04 and older |
| Debian 12 (bookworm) and newer | Debian 11 (bullseye) and older |
| Fedora 36 and newer | RHEL / Rocky / Alma 8 |
| Linux Mint 21, Pop!_OS 22.04, Zorin 17 and newer | openSUSE Leap 15.x |
| Arch, Manjaro, EndeavourOS (rolling) | |

There's no workaround short of building from source on your own machine — see
[Building it yourself](#building-it-yourself) below.

### A missing GTK or audio library

The AppImage deliberately does *not* bundle GTK 3, OpenGL, X11 or the sound
stack: those have to match your machine, not the build machine. Every mainstream
desktop already has them. On a minimal or unusual install you may need:

```sh
sudo apt install libgtk-3-0 libasound2
```

### Something else

Run it from a terminal so you can see what it says:

```sh
./GoCafe-*.AppImage
```

On Wayland, if the window misbehaves, try forcing X11:

```sh
GDK_BACKEND=x11 ./GoCafe-*.AppImage
```

## Where Go Cafe keeps things

- Settings, board-theme choice and logs: `~/.local/share/app.gocafe.gocafe/`
- Cached data: `~/.cache/app.gocafe.gocafe/`
- **Server passwords: your desktop keyring**, through libsecret — the same place
  GNOME, KDE and most browsers keep theirs.

(Both directories follow `XDG_DATA_HOME` / `XDG_CACHE_HOME` if you've set them.)

That last point matters on a machine with no keyring daemon running (a bare
window manager, some server or minimal installs). Without one, Go Cafe can't
save your login and will ask for it every time. Installing and unlocking
`gnome-keyring` fixes it.

## Verifying the download

Each release includes a `.sha256` file next to the AppImage:

```sh
sha256sum -c GoCafe-<version>-x86_64.AppImage.sha256
```

The AppImage is **not** GPG-signed. AppImage signing exists but almost nothing
verifies it, so the checksum is the meaningful check for now.

## Uninstalling

Delete the file. If you added a menu entry by hand, remove
`~/.local/share/applications/gocafe.desktop` too. To also clear your settings,
delete `~/.local/share/app.gocafe.gocafe/` and `~/.cache/app.gocafe.gocafe/`;
your saved logins live in the keyring, under `app.gocafe.gocafe`.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
