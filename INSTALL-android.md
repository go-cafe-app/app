# Installing Go Cafe on Android

Go Cafe is not on the Play Store. You download the APK and open it. Android
asks you to confirm a couple of times the first time, and not again after
that. One APK covers every phone and tablet.

## 1. Download

Open the [Releases page](https://github.com/go-cafe-app/app/releases) on the
phone and download `GoCafe-<version>.apk`.

The browser warns that the file could harm your device. Tap **Download
anyway**. It says that about every APK.

To download on a computer instead, see
[Installing from a computer](#installing-from-a-computer).

## 2. Open it

Tap the download notification, or open **Files → Downloads** and tap the file.

## 3. Allow your browser to install apps

The first time, Android says your phone is not allowed to install unknown apps
from this source. Tap **Settings**, turn on **Allow from this source**, go
back, and tap the APK again.

The permission is for the app you opened the file from, your browser or
Files, not for Go Cafe. To turn it off later, it is under **Settings → Apps →
Special app access → Install unknown apps**.

## 4. Play Protect

Play Protect says it does not recognise the developer, or offers to send the
app to Google for a scan. Tap **More details**, then **Install anyway** or
**Install without scanning**. Then tap **Install**.

Play Protect says this about every app that did not come through the Play
Store. It has not found anything. It has no record of this developer.

## Updates

Go Cafe checks for a new version when it starts. When there is one, a card in
the corner shows what changed. Tap **Install**: the app downloads the APK,
checks it against the published checksum and hands it to Android, which asks
"Do you want to update this app?". Tap **Update**. Android closes the app to
install it. Open it again from the launcher. Your settings and your login are
kept.

The first time, Android asks whether Go Cafe may install apps. It opens the
Settings screen with the toggle. Turn it on and go back. If you would rather
not, tap **Download** on the card and install the APK from the browser as
above.

**Skip this version** hides that version for good. **Settings → About →
Version** shows which version you have and checks again when you tap it.

### By hand

Download the newer APK and open it as before. Android installs it over the old
one and keeps your settings and login. Every release is signed with the same
key. If you get **"App not installed"**, see below.

### Obtainium

[Obtainium](https://github.com/ImranR98/Obtainium) watches a GitHub releases
page and tells you when there is a new version. Add
`https://github.com/go-cafe-app/app` inside it. Go Cafe does not need it. It
still asks you to confirm each install.

## If something goes wrong

### "App not installed"

One of three things:

- The download is incomplete. Delete it and download again.
- You have a build signed with a different key, for example one you were sent
  directly. Android will not replace it. Uninstall Go Cafe first. You lose
  your settings and sign in again, once.
- The version is older than the one you have. Android does not downgrade.
  Uninstall first.

### "There was a problem parsing the package"

The file is damaged, or the phone runs an Android older than 7.0. Check
**Settings → About phone → Android version**.

### It installs but can't reach a server

Check that you are online. Go Cafe connects to Go servers on their own ports,
and some networks block that, school and workplace Wi-Fi especially. Mobile
data tells you which it is.

### Installing from a computer

Copy the APK to the phone over USB, or put it in your cloud drive and open it
from that app on the phone. The "allow from this source" permission then
applies to that app.

With `adb` set up, this skips every dialog:

```sh
adb install -r GoCafe-<version>.apk
```

## Verifying the download

Each release has a `.sha256` file next to the APK. On a computer, before you
copy the file across:

```sh
sha256sum -c GoCafe-<version>.apk.sha256
```

## Where Go Cafe keeps things

Settings, board choice, logs and your login are in Go Cafe's private storage,
which no other app can read. Uninstalling deletes all of it. The app uses no
external storage. It asks for two permissions: internet, and permission to
install its own updates, which you grant in Settings only if you want them.

## Requirements

- Android 7.0 or newer
- Any processor. The APK contains arm64, arm32 and x86_64 builds.
- About 200 MB of storage

## Uninstalling

Long-press the icon and tap **Uninstall**, or **Settings → Apps → Go Cafe →
Uninstall**. Nothing is left behind.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
