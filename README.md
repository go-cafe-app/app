# Go Cafe

A native client for playing Go — Baduk, Weiqi — online, on
[Fox (foxwq)](https://www.foxwq.com/). Board, clocks, lobby and history, without
a browser.

<table>
<tr>
<td width="50%"><img src="screenshots/profile-light.png" alt="The lobby, with a player card open over it: won, lost, drawn and played totals, split by rank and by ranked or friendly, and a recent-form strip of wins and losses."></td>
<td width="50%"><img src="screenshots/profile-dark.png" alt="The same screen in the dark theme."></td>
</tr>
</table>

Go Cafe isn't in any app store, and isn't signed yet — which your computer will
have opinions about. See below.

## Download

**[→ Latest release](../../releases/latest)**

| Platform | File | Guide |
|---|---|---|
| **macOS** 10.15+, Apple Silicon and Intel | `GoCafe-<version>.dmg` | [install](INSTALL-macos.md) |
| **Windows** 10 and 11, 64-bit | `GoCafe-<version>-windows-x64.zip` | [install](INSTALL-windows.md) |
| **Linux** x86_64, glibc 2.35+ | `GoCafe-<version>-x86_64.AppImage` | [install](INSTALL-linux.md) |
| **Android** 7.0+ | `GoCafe-<version>.apk` | [install](INSTALL-android.md) |

Linux needs **glibc 2.35 or newer** — Ubuntu 22.04+, Debian 12+, Fedora 36+.
Older than that and it won't start. Android is one APK for every device.

## A look around

**Pick your board and stones.** A selection of boards and stone sets to mix and
match, in a simple, clean interface.

<table>
<tr>
<td width="50%"><img src="screenshots/boards-picker.png" alt="The board and stone picker: a live board on the left updates as sets are chosen from a gallery on the right, grouped by the artist who made them."></td>
<td width="50%"><img src="screenshots/board-photographed.png" alt="A game in progress on a photographed board, its grain and wear visible under shell-and-slate stones."></td>
</tr>
</table>

**See who you're playing, as the game starts.** Your opponent's form and record
are in front of you from the first move, so you can decide whether to play on
without extra work to look up their profile.

<p align="center">
  <img src="screenshots/opponent-form.png" width="420"
       alt="A small panel headed YOUR OPPONENT: their form at this rank as a strip of wins and losses, games played today, their record at this rank, their total games, and the year they joined.">
</p>

**Watch live games, professional broadcasts included** — with the commentary and
the engine's read on the position as it happens. Player and tournament names are
translated into English.

<p align="center">
  <img src="screenshots/watch-broadcast.png" width="900"
       alt="A professional game being broadcast: the board fills the window, and a side panel carries both players, the engine's win rate, a move navigator and a running commentary.">
</p>

## Your computer will warn you

Nothing is wrong with the app. The warning means nobody has paid to vouch for it,
which is a different thing — signing certificates cost money, and Go Cafe isn't
signed yet.

- **macOS** — *"Apple cannot check it for malicious software"*, offering only
  Move to Trash. Click **Cancel**, then open **System Settings → Privacy &
  Security**, scroll down and click **Open Anyway**. (On macOS 14 and earlier:
  right-click the app → **Open** instead.)
- **Windows** — a blue *"Windows protected your PC"* panel. **More info** →
  **Run anyway**.
- **Android** — *"Unsafe app blocked"*. **More details** → **Install anyway**.
- **Linux** — nothing. `chmod +x` and run it.

Each guide above has the full walkthrough plus the handful of things that go
wrong. Worth a look before you start.

## Checking the download

Every file has a `.sha256` next to it:

```sh
sha256sum -c GoCafe-<version>.apk.sha256     # shasum -a 256 -c on macOS
```

A half-finished download is the most common reason an install fails, and this
catches it in a second.

## Something broken?

Open an [issue](../../issues) — what you did, what happened, your platform and
version. Each guide says where your session log lives; attaching it helps a lot.
Nothing is too small to report.

## Credits

Board and stone artwork is other people's work under MIT and CC BY-SA 4.0, each
set credited by name, author and licence on the app's **Settings → Credits**
screen.

Go Cafe is an unofficial client, not affiliated with or endorsed by Fox Weiqi.
