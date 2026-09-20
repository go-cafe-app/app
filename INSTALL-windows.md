# Installing Go Cafe on Windows

Go Cafe ships for Windows as a portable zip. There is no installer, nothing in
the registry and nothing in Program Files. Unzip it, run it, and delete the
folder when you are done.

## 1. Download and unblock

Download `GoCafe-<version>-windows-x64.zip` from the
[Releases page](https://github.com/go-cafe-app/app/releases).

Before you extract it:

1. Right-click the `.zip` and choose **Properties**.
2. At the bottom of the General tab, tick **Unblock** if it is there.
3. Click **OK**.

That checkbox marks the file as downloaded from the internet. Clearing it on
the zip clears it on every file inside. If there is no checkbox, carry on.

## 2. Extract

Right-click the zip, choose **Extract All…**, then **Extract**. You get a
folder called `GoCafe-<version>-windows-x64`.

Move the folder wherever you like. Keep it together: `gocafe.exe` needs the
`data` folder and the `.dll` files next to it.

## 3. Run it

Double-click **gocafe.exe** in the folder.

For a shortcut, right-click `gocafe.exe`, choose **Show more options → Send
to → Desktop (create shortcut)**, or drag it onto the taskbar.

## The warning

If you did not unblock the zip, Windows shows a blue box: **Windows protected
your PC**. Click **More info**, then **Run anyway**. That is once. Windows
remembers.

Go Cafe is not code-signed, and SmartScreen shows this for any program it has
not seen many people run. It is not a virus warning. **Run anyway** changes no
setting and applies to this one program.

To check the file yourself first, upload the zip to
[VirusTotal](https://www.virustotal.com/), or verify the checksum below.

## Updates

Go Cafe checks for a new version when it starts. When there is one, a card in
the corner shows what changed, with a **Download** button that opens the
release page. Download the new zip, extract it, and replace the folder. Your
settings are kept, because they live outside the folder.

**Skip this version** hides that version for good. **Settings → About →
Version** shows which version you have and checks again when you tap it.

## If it doesn't start

### "VCRUNTIME140_1.dll was not found" or "msvcp140.dll"

Those files are in the zip. You have probably run `gocafe.exe` after copying
it out of the folder on its own. Put it back with the other files.

### It flashes a window and disappears

A file is missing: the `.exe` was extracted without the `data` folder next to
it, or an antivirus quarantined part of it. Delete the folder, extract the zip
again, and check the antivirus quarantine list.

### Your antivirus deletes it

Unsigned programs from small projects get false positives, especially with
Avast, AVG and Norton. The checksum below tells you the file is exactly what
was built. Adding an exclusion for the folder is the usual fix. If you would
rather not, wait for a signed build.

### It opens but can't reach a server

Check that you are online, and whether a VPN, a corporate firewall or a family
safety filter is in the way. Go Cafe connects to Go servers on their own
ports, and some networks block that. Windows Firewall may ask whether to allow
Go Cafe on the network the first time. Say yes.

## Where Go Cafe keeps things

- Settings, board choice and logs: `%APPDATA%\app.gocafe\gocafe\`. Paste that
  into the File Explorer address bar.
- Server passwords: Windows Credential Manager, where Windows keeps the
  passwords it saves for you.

Nothing lives in the program folder, so you can replace the folder with a
newer version and keep your settings.

## Verifying the download

Each release has a `.sha256` file next to the zip. In PowerShell, from your
Downloads folder:

```powershell
Get-FileHash .\GoCafe-<version>-windows-x64.zip -Algorithm SHA256
```

Compare the result with the `.sha256` file. Case does not matter.

## Uninstalling

Delete the folder. To clear your settings, delete
`%APPDATA%\app.gocafe\gocafe\`. Your saved login is in Credential Manager,
under **Windows Credentials**, as `app.gocafe.gocafe`.

## Requirements

- Windows 10 version 1809 or newer, 64-bit, or Windows 11
- About 250 MB of disk space
- Windows on ARM runs the x64 build under emulation

## Reporting a problem

Attach the session log. Paste this into the File Explorer address bar:

```
%APPDATA%\app.gocafe\gocafe\gocafe-session.log
```

It records the app's conversation with the Go server for the current session.
It does not contain your password.

---

*Generated from the Go Cafe source repository — edits made here are overwritten at the next release.*
