# Installing Go Cafe on a Mac

There are two ways. The first takes ten seconds and shows no warning. The
second is the usual drag to Applications, with one extra step the first time.

## One line in Terminal

Open Terminal (press ⌘-Space, type `Terminal`, press Return). Paste this line
and press Return:

```
curl -fsSL https://raw.githubusercontent.com/go-cafe-app/app/main/install.sh | bash
```

It downloads the latest version, checks it against the published checksum,
puts Go Cafe in your Applications folder and opens it. If Go Cafe is already
there, it is replaced.

macOS shows no warning, because the warning is for files a browser downloaded
and this one was not. Nothing on your Mac is changed or switched off. The
script is [install.sh](install.sh), one page of shell you can read first.

## The disk image

1. Open `GoCafe-<version>.dmg`.
2. Drag **Go Cafe** onto the **Applications** folder next to it. Then eject
   the image.
3. Open Go Cafe from Applications. macOS says it "can't be opened because
   Apple cannot check it for malicious software". Click **Cancel**.
4. Open **System Settings → Privacy & Security** and scroll to the bottom.
   Next to the line about Go Cafe, click **Open Anyway** and confirm.

That is once. After that it opens like any other app.

On macOS 14 and earlier, skip step 4: right-click Go Cafe in Applications,
choose **Open**, and click **Open** again.

## Updates

Go Cafe checks for a new version when it starts. When there is one, a card in
the corner shows what changed. Click **Install**: it downloads, verifies and
swaps itself over, then restarts. Click ✕ to put the card away until the next
launch, or **Skip this version** to not hear about that version again.

**Settings → About → Version** shows which version you have and checks again
when you tap it.

An update opens with no warning, whichever way you first installed.

## Why the warning

Go Cafe is not signed with an Apple Developer certificate, and macOS warns
about every app Apple has not notarised. **Open Anyway** changes no setting
and applies to this one app.

## Signing in

**Stay signed in** keeps a session token in the app's data folder. Your
password is not stored.

## If something goes wrong

**"Go Cafe is damaged and can't be opened."** The download is incomplete.
Delete the app and the disk image, then use the one line in Terminal, which
checks the download before installing.

**There is no Go Cafe line in Privacy & Security.** The line appears after
macOS blocks a launch from Applications, and not always after one from the
disk image. Open the app from Applications once more, then look again.

**The update card says Go Cafe can't write to its own folder.** It is running
from the disk image, or from a folder your account cannot change. Run the one
line in Terminal.

**It opens but can't reach a server.** Check that you are online. Go Cafe
connects to Go servers on their own ports, and some VPNs and office networks
block that.

## Requirements

macOS 10.15 or newer, on Apple Silicon or Intel.

## Reporting a problem

Attach the session log:

```
~/Library/Application Support/app.gocafe.gocafe/gocafe-session.log
```

Up to version 1.2.2 it was under
`~/Library/Containers/app.gocafe.gocafe/Data/Library/Application Support/app.gocafe.gocafe/`.

The log records the app's conversation with the Go server for the current
session. It does not contain your password.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
