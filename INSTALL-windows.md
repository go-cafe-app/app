# Installing Go Cafe on Windows

Thanks for testing. This takes about a minute.

Go Cafe ships for Windows as a **portable zip** — no installer, nothing written
to your registry, nothing in Program Files. You unzip it, run it, and delete the
folder when you're done with it.

## 1. Download and unblock

Download `GoCafe-<version>-windows-x64.zip` from the
[Releases page](https://github.com/go-cafe-app/app/releases).

Before you extract it, do this — it saves you a warning later:

1. Right-click the downloaded `.zip` → **Properties**.
2. At the bottom of the General tab, if there's an **Unblock** checkbox, tick it.
3. **OK**.

That checkbox is Windows saying "this came from the internet." Ticking it on the
zip means the files inside come out clean. If the checkbox isn't there, nothing
is wrong — some browsers don't set the flag. Carry on.

## 2. Extract

Right-click the zip → **Extract All…** → **Extract**. You get a folder called
`GoCafe-<version>-windows-x64`.

Move that folder wherever you like — Documents, the Desktop, anywhere. Keep it
together: `gocafe.exe` needs the `data` folder and the `.dll` files sitting next
to it.

## 3. Run it

Double-click **gocafe.exe** inside the folder.

If you want it somewhere convenient, right-click `gocafe.exe` → **Show more
options** → **Send to** → **Desktop (create shortcut)**, or drag it onto the
taskbar to pin it.

## The warning you will probably see

If you didn't unblock the zip in step 1, Windows shows a blue box:

> **Windows protected your PC**
> Microsoft Defender SmartScreen prevented an unrecognised app from starting.

There's a **Don't run** button and, at first glance, nothing else. The way past
it is:

1. Click **More info** (small link, above the button).
2. A **Run anyway** button appears. Click it.

That's it — you only have to do this once. Windows remembers.

### Why does that happen?

Go Cafe isn't code-signed yet. A Windows code-signing certificate costs a few
hundred pounds a year from a certificate authority, and this is an early test
build, so it doesn't have one.

SmartScreen shows that box for **any** program it hasn't seen many people run
before, signed or not. It isn't a virus warning and it isn't telling you the app
is malicious — it's telling you Windows doesn't recognise it yet. Clicking
**More info → Run anyway** is Microsoft's own built-in way of saying "yes, I
know where this came from." It doesn't turn off any security setting and it
applies to this one program only.

If you'd rather check for yourself first, upload the zip to
[VirusTotal](https://www.virustotal.com/) — or verify the checksum, see below.

## If it doesn't start

### "VCRUNTIME140_1.dll was not found" (or msvcp140.dll)

This shouldn't happen — those files are shipped inside the zip — but if it does,
you've probably run `gocafe.exe` on its own after copying it out of the folder.
Put it back with the rest of the files and run it from there.

### It flashes a window and disappears

Almost always a missing file: something extracted the `.exe` without the `data`
folder next to it, or an antivirus quarantined part of it. Delete the folder,
extract the zip again, and check your antivirus's quarantine list.

### Your antivirus deletes it

Unsigned executables from small projects get false positives from time to time,
especially with Avast, AVG and Norton. The checksum below tells you the file is
exactly what was built; adding an exclusion for the folder is the usual fix. If
you'd rather not, that's completely reasonable — say so and wait for a signed
build.

### It opens but can't reach a server

Check you're online, then check whether a VPN, a corporate firewall or a "family
safety" filter is in the way. Go Cafe talks to Go servers directly on their own
ports rather than over ordinary web traffic, and some restrictive networks block
exactly that. Windows Firewall may also pop up a "Allow Go Cafe to communicate
on these networks?" prompt the first time — say yes.

## Where Go Cafe keeps things

- Settings, board theme, logs:
  `%APPDATA%\app.gocafe\gocafe\`
  (paste that into the File Explorer address bar)
- **Server passwords: Windows Credential Manager**, the same place Windows keeps
  the passwords it saves for you. Not in the folder, and not in the zip.

Because everything lives outside the program folder, you can delete and replace
the folder with a newer version and keep your settings.

## Verifying the download

Every release includes a `.sha256` file next to the zip. In PowerShell, from
your Downloads folder:

```powershell
Get-FileHash .\GoCafe-<version>-windows-x64.zip -Algorithm SHA256
```

Compare what it prints with the contents of the `.sha256` file — they should
match, ignoring upper/lower case.

## Uninstalling

Delete the folder. That's the whole thing.

To also clear your settings, delete `%APPDATA%\app.gocafe\gocafe\`. Your saved
login is in Credential Manager (Control Panel → User Accounts → Credential
Manager → Windows Credentials), under `app.gocafe.gocafe`.

## Requirements

- Windows 10 version 1809 (October 2018) or newer, 64-bit — and Windows 11
- About 250 MB of disk space
- Windows on ARM works too: it runs the x64 build under emulation

## Reporting problems

There's a log that makes bugs far easier to diagnose. Paste this into the File
Explorer address bar and attach the file to your report:

```
%APPDATA%\app.gocafe\gocafe\gocafe-session.log
```

It records the app's conversation with the Go server for the current session. It
does not contain your password.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
