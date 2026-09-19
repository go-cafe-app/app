# Installing Go Cafe on your Mac

Thanks for testing. This takes about a minute.

## 1. Open the disk image

Double-click **GoCafe-<version>.dmg**. A window opens with the Go Cafe icon and a
shortcut to your Applications folder.

## 2. Drag Go Cafe into Applications

Drag the **Go Cafe** icon onto the **Applications** folder next to it.

Then eject the disk image: click the ⏏ next to "Go Cafe" in the Finder sidebar,
or drag it to the Trash. (You are ejecting the image, not deleting the app.)

## 3. First launch — the important bit

Double-click **Go Cafe**. macOS blocks it and says

> "Go Cafe" can't be opened because Apple cannot check it for malicious software.

and offers you only **Move to Trash** or **Cancel**. Click **Cancel** — nothing
is wrong with the app, and this is the step that gets past it:

1. Open **System Settings → Privacy & Security**.
2. Scroll to the bottom. There is a line about Go Cafe being blocked, with an
   **Open Anyway** button next to it.
3. Click **Open Anyway**, then confirm.

That is it. From then on Go Cafe opens normally with a double-click — you only
need to do this once.

### On macOS 14 (Sonoma) and earlier

Older macOS has a shortcut for this that Apple has since removed. Instead of
System Settings: **right-click** (or Control-click) Go Cafe in Applications,
choose **Open**, and click **Open** again in the warning. Everything else is the
same.

## Why does macOS warn me?

Go Cafe is not signed with an Apple Developer certificate yet. Apple charges an
annual fee for one, and this build is an early test version, so it does not have
one. macOS shows the same warning for any app it has not seen notarised by
Apple, regardless of whether the app is fine.

**Open Anyway** is macOS's own built-in way of saying "yes, I know where this
came from, let it run." It does not disable any security setting on your Mac,
and it applies only to this one app.

## Anything not working?

Nothing, as of this build. **"Stay signed in" works.** It used to not: an
unsigned app cannot use the macOS Keychain, so the tick box looked like it
worked and saved nothing. Fox is now remembered as a rotating session token kept
in the app's own container instead of a password in the Keychain, which needs no
signature and no permission prompt. Your password is not stored at all.

## If something goes wrong

**"Go Cafe is damaged and can't be opened."**
This usually means the download was incomplete or the file was unpacked by
something that stripped it. Delete the app and the .dmg, download again, and
retry step 3. If it persists, run this in Terminal and try once more:

```
xattr -dr com.apple.quarantine "/Applications/Go Cafe.app"
```

**There is no Go Cafe line in Privacy & Security.**
It only appears after macOS has blocked a launch, and it clears itself after a
while. Try to open the app once more, then look again — the line should be at
the bottom of the page, under **Security**.

Make sure you are opening the app from **Applications**, not from the
still-mounted disk image; a blocked launch from inside the image does not always
produce the line.

**It opens but cannot reach a server.**
Check that you are online, then confirm no VPN or corporate firewall is blocking
outbound connections. Go Cafe talks to Go servers directly on their own ports,
not over plain web traffic, and some restrictive networks block that.

## Requirements

- macOS 10.15 or newer
- Works on both Apple Silicon and Intel Macs

## Reporting problems

If the app misbehaves, there is a log that makes it much easier to diagnose.
Copy it into a bug report:

```
~/Library/Containers/app.gocafe.gocafe/Data/Library/Application Support/app.gocafe.gocafe/gocafe-session.log
```

It records the app's conversation with the Go server for the current session. It
does not contain your password.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
