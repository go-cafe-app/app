# Installing Go Cafe on Android

Go Cafe isn't on the Play Store. You install it by downloading the `.apk` file
and opening it — "sideloading". Android makes you confirm this a couple of times
the first time you do it, and then never asks again.

It's one APK for every phone and tablet, so there's nothing to choose.

## 1. Download the APK

Open the
[Releases page](https://github.com/go-cafe-app/app/releases)
**on the phone** and download `GoCafe-<version>.apk`.

(Downloading on a computer and copying the file across works too — see
[Installing from a computer](#installing-from-a-computer) below.)

Your browser will warn you that "this type of file can harm your device". Tap
**Download anyway**. Android says that about every APK.

## 2. Open it

Tap the download notification, or find the file in **Files** → **Downloads** and
tap it.

## 3. Allow your browser to install apps

The first time, Android says something like:

> For your security, your phone is not allowed to install unknown apps from this
> source.

Tap **Settings** in that dialog and turn on **Allow from this source**, then come
back and tap the APK again.

This permission is granted to the *app you're installing from*, not to Go Cafe —
so it's your browser (or Files) you're allowing. If you'd rather find it by hand
later, it's under **Settings → Apps → Special app access → Install unknown
apps**. It's worth turning back off afterwards if you don't sideload often.

## 4. Play Protect will check it

You'll probably see:

> **Unsafe app blocked** — Play Protect doesn't recognise this app's developer.

Tap **More details**, then **Install anyway**.

Play Protect flags every app it hasn't seen distributed through the Play Store.
It isn't saying anything was found; it's saying it has no history for this
developer. On some phones the dialog instead offers to send the app to Google for
scanning, which is fine too.

Then tap **Install**. That's it.

## Updating to a new version

Download the newer APK and open it the same way. Android installs it over the
top: **your settings and your saved login are kept**, and you don't have to
uninstall anything. The "allow from this source" permission is already granted,
so it's two taps.

Every release is signed with the same key, which is what makes updating in place
work. If you ever get **"App not installed"** on an update, see below.

### Optional: automatic updates with Obtainium

[Obtainium](https://github.com/ImranR98/Obtainium) is a free open-source app that
watches a GitHub releases page and tells you when there's a new version, so you
don't have to check. Add `https://github.com/go-cafe-app/app` as an app
inside it and it handles the rest.

Completely optional — Go Cafe doesn't need it and doesn't know about it. Two
things to know if you try it:

- It still asks you to confirm each install; it automates the checking, not the
  installing.

## If something goes wrong

### "App not installed" or "App not installed as package appears to be invalid"

Usually one of three things:

- **The download was truncated.** Delete it and download again — a half-finished
  APK is the most common cause.
- **You already have a build signed with a different key**, for example one
  someone sent you directly earlier on. Android will not replace an app with one
  signed by a different key. Uninstall Go Cafe first, then install. You'll lose
  your settings and have to sign in again; this only happens once.
- **The version you're installing is older than the one you have.** Android
  refuses to downgrade. Uninstall first.

### "There was a problem parsing the package"

The file is damaged, or your Android is older than 7.0. Check
**Settings → About phone → Android version**.

### It installs but can't reach any server

Check you're online and that a VPN or a network filter isn't in the way. Go Cafe
talks to Go servers directly on their own ports rather than as ordinary web
traffic, and some networks — school and workplace Wi-Fi especially — block that.
Mobile data is a good thing to test with to tell the two apart.

### Installing from a computer

If you downloaded on a computer, copy the APK to the phone over USB (it'll appear
in **Files → Internal storage**), or put it in your own cloud drive and open it
from that app on the phone. The "allow from this source" permission then applies
to whichever app you opened it from.

With `adb` set up, this also works and skips all the dialogs:

```sh
adb install -r GoCafe-<version>.apk
```

## Verifying the download

Each release includes a `.sha256` file next to the APK. Checking it on a phone is
fiddly; on a computer, before you copy the file across:

```sh
sha256sum -c GoCafe-<version>.apk.sha256
```

## Where Go Cafe keeps things

Everything — settings, board theme, logs, saved login — lives in Go Cafe's own
private storage, which no other app can read. Uninstalling deletes all of it.

The one thing that isn't private to the app is nothing: there is no external
storage use at all, and the app asks for a single permission, `INTERNET`.

## Requirements

- Android 7.0 (Nougat) or newer
- Any processor — the APK contains arm64, arm32 and x86_64 builds
- About 200 MB of storage

## Uninstalling

Long-press the icon → **Uninstall**, or **Settings → Apps → Go Cafe →
Uninstall**. Nothing is left behind.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
