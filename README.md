<p align="center">
  <img src="assets/logo.png" alt="SyPB Logo" width="220"/>
</p>

<h1 align="center">SyPB for Linux</h1>

<p align="center">
  <b>High-Performance Artificial Intelligence Bot for Counter-Strike 1.6 & Condition Zero on Linux</b><br/>
  <i>Engineered for ReHLDS, classic HLDS, Metamod, and Metamod-r with deep Zombie Plague, Biohazard, and CSDM support.</i>
</p>

<p align="center">
  <a href="https://github.com/FompusDev/SyPB-Linux/releases"><img src="https://img.shields.io/github/v/release/FompusDev/SyPB-Linux?style=flat-square&color=blue&label=Release" alt="GitHub release"/></a>
  <img src="https://img.shields.io/badge/Platform-Linux%20x86%20(i386)-orange?style=flat-square&logo=linux" alt="Platform"/>
  <img src="https://img.shields.io/badge/Engines-ReHLDS%20%7C%20HLDS-brightgreen?style=flat-square" alt="Engines"/>
  <img src="https://img.shields.io/badge/Metamod-1.21%20%7C%201.3.0%20%7C%20Metamod--r-blueviolet?style=flat-square" alt="Metamod"/>
  <img src="https://img.shields.io/badge/C%2B%2B-GNU%2B%2B11%20%7C%20GCC-informational?style=flat-square&logo=cplusplus" alt="C++11"/>
  <a href="https://sypb.netlify.app/"><img src="https://img.shields.io/badge/Website-sypb.netlify.app-00e5ff?style=flat-square&logo=netlify&logoColor=white" alt="Official Website"/></a>
  <a href="https://discord.gg/dB2HdnHasV"><img src="https://img.shields.io/badge/Discord-Join%20Community-5865F2?style=flat-square&logo=discord&logoColor=white" alt="Discord Community"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-GPL--3.0-lightgrey?style=flat-square" alt="License"/></a>
</p>

<p align="center">
  🌐 <b>Official Website:</b> <a href="https://sypb.netlify.app/"><b>https://sypb.netlify.app/</b></a> &bull; 💬 <b>Discord:</b> <a href="https://discord.gg/dB2HdnHasV"><b>Join Community</b></a>
</p>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Key Linux Port Fixes & Enhancements](#-key-linux-port-fixes--enhancements)
- [Core Features](#-core-features)
- [Quick Start & Installation](#-quick-start--installation)
  - [Prerequisites](#prerequisites)
  - [Automated Installation](#automated-installation)
  - [Manual Installation](#manual-installation)
  - [Metamod Configuration](#metamod-configuration)
- [Configuration & CVAR Reference](#-configuration--cvar-reference)
  - [Primary Settings](#primary-settings)
  - [Combat & Behavior Settings](#combat--behavior-settings)
  - [Game Mode CVARs](#game-mode-cvars)
  - [Console Commands](#console-commands)
- [Waypoint System & In-Game Editor](#-waypoint-system--in-game-editor)
- [Building from Source](#-building-from-source)
- [Troubleshooting & FAQ](#-troubleshooting--faq)
- [Community & Support](#-community--support)
- [Credits & Acknowledgments](#-credits--acknowledgments)
- [License](#-license)

---

## 🌟 Overview

**SyPB** (originally crafted by HsK-Dev Blog and the SyPB Team) is recognized across the Counter-Strike 1.6 modding community as one of the most advanced, human-like, and modular bot modifications ever built. Unlike classic bot engines, SyPB includes native intelligence for specialized gameplay mechanics: complex human camping tactics, dynamic zombie hunting and avoidance, barricade breaking, long-jump leaps, and rich integration with AMX Mod X.

Historically, SyPB was primarily developed and maintained for Windows (`sypb.dll`). Linux server administrators faced severe compilation roadblocks, missing symbol linkages, broken waypoint loaders, and sudden heap memory corruption.

**SyPB-Linux** is a fully restored, patched, and modern release targeting Linux x86 dedicated servers. It delivers rock-solid stability, zero memory corruption, automated waypoint loading, and guaranteed auto-join functionality out of the box.

---

## 🛠 Key Linux Port Fixes & Enhancements

This repository contains critical low-level engine and algorithm patches to ensure 100% stable execution on Linux:

| Issue in Upstream / Legacy Builds | Root Cause | Resolution in SyPB-Linux |
| :--- | :--- | :--- |
| **Missing Waypoints on Map Load** | `g_waypoint->Load()` was locked inside `#ifdef PLATFORM_WIN32` in `interface.cpp`. | Hooked automatic waypoint loading in `ServerActivate` for Linux. Waypoints now load instantly when the map starts. |
| **Fatal Server Crash (`navigate.cpp:703`)** | `PriorityQueue` in the A* pathfinder allocated nodes using C++ `new[]` but resized via standard C `realloc()`. | Completely overhauled `PriorityQueue` to use pure, aligned `malloc`/`realloc`/`free` with double-growth scaling and defensive boundary checks. |
| **Quota Reset to 0 on Map Start** | `sypb_quota.SetInt(0)` was triggered inside `RemoveAll()`, `MaintainBotQuota()`, and `AddBotAPI()` upon transient errors. | Removed destructive quota wipes; implemented graceful retry timers and persistent auto-exec configuration hooks. |
| **GLIBC Symbol Incompatibility** | Compiling on modern Linux distros (GLIBC 2.34+) caused `undefined symbol: powf` or `GLIBC_2.33 not found` on older hosting distros. | Compiled against clean Debian 10 Buster (GLIBC 2.28) with `-static-libgcc` and `-static-libstdc++`. Runs seamlessly across Debian, Ubuntu, CentOS, AlmaLinux, and Arch. |
| **Bundled Waypoint Database** | Fresh installations lacked navigation files for popular Zombie Plague and competitive maps. | Packaged with **58+ production-ready waypoints** (`.pwf`) for classic maps and top Zombie Plague environments. |

---

## ⚡ Core Features

### 🧠 Tactical AI & Human-Like Movement
- **Humanized Shooting Mechanics**: Authentic recoil compensation, trigger tapping, burst firing, and dynamic target leading.
- **Advanced Movement**: Real bunny-hopping, duck-jumping over obstacles, crouch-sliding, and tactical strafing during firefights.
- **Auditory Perception**: Bots listen for nearby enemy footsteps, weapon switches, ladder climbs, and reloading cues.
- **Flashbang Reaction**: Bots turn away from incoming flashbangs and spray wildly if blinded.

### 🧟 Native Zombie Plague & Mod Support
- **Zombie Plague (ZP 4.3, 5.0, Nightmare)**: Automatic game mode detection (`sypb_gamemod 2`). Zombies recognize human camp spots, hunt in swarms, coordinate leap jumps, and break obstacles.
- **Human Survival Logic**: Humans actively seek secure camp bunkers, cover all defensive angles, and avoid infected hordes.
- **Biohazard & Zombie Hell**: Native support with configurable delay timers and target scoring.
- **CSDM (Deathmatch & Team Deathmatch)**: Instant weapon selection, rapid roaming, and continuous combat loops.

### 🧭 Dynamic Navigation & Floyd-Warshall Pathfinder
- Dual-tier routing combining **A\* heuristic search** for local goals and **Floyd-Warshall distance tables** for map-wide routing.
- Built-in GitHub waypoint auto-downloader (`sypb_download_waypoint 1`) retrieves missing navigation meshes automatically.
- Integrated interactive waypoint editor (`sypb sgdwp on`) with live HUD visualizers.

---

## 🚀 Quick Start & Installation

### Prerequisites
- Counter-Strike 1.6 or Condition Zero dedicated server (ReHLDS recommended, or classic HLDS build 4554+ / 8684+).
- **Metamod 1.21+** or **Metamod-r**.

---

### Automated / Binary Installation

1. Download the latest precompiled release archive from **[Releases](https://github.com/FompusDev/SyPB-Linux/releases)** (`sypb-linux-v1.50.tar.gz` or `sypb-linux-v1.50.zip`).
2. Extract the archive into your server's `cstrike/` directory so that the following structure is created:
   ```text
   cstrike/
   └── addons/
       └── sypb/
           ├── dlls/
           │   └── sypb_i386.so
           ├── wptdefault/
           │   ├── de_dust2.pwf
           │   ├── zm_inferno_nature_rr.pwf
           │   └── ... (58+ maps)
           ├── general.cfg
           └── sypb.cfg
   ```

---

### Metamod Configuration

Open `cstrike/addons/metamod/plugins.ini` and append the following line:

```ini
linux addons/sypb/dlls/sypb_i386.so
```

> [!TIP]
> If using **Metamod-r**, placing `linux addons/sypb/dlls/sypb_i386.so` anywhere in `plugins.ini` will work. If other bot management plugins exist (such as legacy `bot_controller.amxx`), ensure they are disabled to prevent external quota overriding.

---

### Server Config Integration

Add the auto-exec statement to the bottom of `cstrike/server.cfg`:

```cfg
// Exec SyPB Bot Configuration
exec addons/sypb/sypb.cfg
```

Restart your server or change the map. In the server console, type `meta list` to verify:
```text
[ 1] SyPB, vBeta 1.50, 2026/11/15, by SyPB Team & _unique_, see 'addons/sypb'
```

---

## ⚙ Configuration & CVAR Reference

All settings can be customized in `cstrike/addons/sypb/sypb.cfg` or executed live via RCON.

### Primary Settings

| CVAR | Default | Range | Description |
| :--- | :---: | :---: | :--- |
| `sypb_quota` | `10` | `0` - `32` | Specifies the total number of SyPB bots active on the server. |
| `sypb_difficulty` | `2` | `0` - `4` | Bot skill level: `0` (Easy), `1` (Normal), `2` (Hard), `3` (Expert), `4` (Godlike). |
| `sypb_join_after_player` | `0` | `0` / `1` | `0`: Bots enter immediately on empty server. `1`: Bots join only after at least one human player connects. |
| `sypb_forceteam` | `any` | `any`, `ct`, `t` | Forces joining bots into a specific team. |
| `sypb_download_waypoint` | `1` | `0` / `1` | Automatically download missing `.pwf` waypoints from the online repository if not found locally. |
| `sypb_language` | `en` | `en`, `cn` | Language for bot menus, HUD announcements, and chat messages. |
| `sypb_nametag` | `0` | `0` / `1` | Prefixes bot nicknames with `[SyPB]` when enabled. |

### Combat & Behavior Settings

| CVAR | Default | Range | Description |
| :--- | :---: | :---: | :--- |
| `sypb_followpercent` | `50` | `0` - `100` | Percentage probability that a bot will follow a human teammate at round start. |
| `sypb_chat` | `0` | `0` / `1` | Enables or disables bot radio chatter and text messages. |
| `sypb_knifemode` | `0` | `0` / `1` | Forces all bots to use knives only. |
| `sypb_spraypaints` | `0` | `0` / `1` | Permits bots to apply spray decals after killing enemies or winning rounds. |
| `sypb_stopbots` | `0` | `0` / `1` | Temporarily freezes all bot logic and movement when set to `1`. |
| `sypb_restrictweapons` | `shield;...` | string | Semicolon-delimited list of restricted weapons (e.g. `awp;m249;shield`). |

### Game Mode CVARs

| CVAR | Default | Description |
| :--- | :---: | :--- |
| `sypb_gamemod` | `2` | `0` = Standard/Defuse, `1` = Team Deathmatch, `2` = Zombie Plague, `3` = Zombie Hell. |
| `sypb_zmdelay_time` | `Auto` | Delay before the infection countdown begins in Zombie Plague mode. |
| `sypb_dangerfactor` | `800` | Danger weighting factor used in obstacle and hazard avoidance. |

---

## 🎮 Console Commands

You can run these commands from the server console, RCON, or your in-game console (with administrative access):

```bash
# Bot Management
sypb add                    # Adds a bot with random parameters
sypb add [skill] [team]     # Adds a bot with specific skill (0-100) and team (1=T, 2=CT)
sypb fillserver 5 -1 -1 10  # Fills the server with 10 random bots
sypb kickall                # Kicks all active SyPB bots
sypb killall                # Slay all bots instantly

# In-Game Interactive Menu
sypb menu                   # Opens the comprehensive in-game bot configuration menu

# Waypoint Editor
sypb sgdwp on               # Activates the visual in-game waypoint creator
sypb sgdwp off              # Deactivates the waypoint editor
sypb sgdwp save             # Manually saves waypoints for the current map
```

---

## 🗺 Waypoint System & In-Game Editor

SyPB uses high-speed binary waypoint files (`.pwf`) located in `addons/sypb/wptdefault/`.

1. **Automatic Loading**: When a map is loaded, SyPB searches for `addons/sypb/wptdefault/<mapname>.pwf`.
2. **Auto-Download**: If no local waypoint is found and `sypb_download_waypoint 1` is enabled, the module attempts to download a certified waypoint file directly into your server.
3. **Built-in Editor**:
   - Join your server as an administrator.
   - Type `sypb sgdwp on` in the console.
   - Walk through the map; paths and jump points will render with visual laser beams and HUD coordinates.
   - When finished, type `sypb sgdwp save` and reload the map.

---

## 🔨 Building from Source

You can compile `sypb_i386.so` using the provided Docker build environment, ensuring perfect cross-distro GLIBC compatibility.

### Using Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/FompusDev/SyPB-Linux.git
cd SyPB-Linux

# Run the automated build container
docker run --rm -v $(pwd):/SyPB i386/debian:10 bash -c "
  set -e
  echo 'deb http://archive.debian.org/debian buster main' > /etc/apt/sources.list
  echo 'deb http://archive.debian.org/debian-security buster/updates main' >> /etc/apt/sources.list
  apt-get -o Acquire::Check-Valid-Until=false update
  apt-get install -y --allow-unauthenticated build-essential
  cd '/SyPB/Project SyPB/SyPB_BOT'
  g++ -m32 -O2 -std=gnu++11 -fPIC -fvisibility=default -w \
      -I./include -I. -I.. -I../.. \
      -D__linux__ -Dlinux -D_GNU_SOURCE -DPLATFORM_LINUX32 \
      -static-libgcc -static-libstdc++ \
      -shared source/*.cpp -ldl -lm -o sypb_i386.so
  cp sypb_i386.so /SyPB/addons/sypb/dlls/sypb_i386.so
"
```

The resulting library `addons/sypb/dlls/sypb_i386.so` will be fully compiled and ready for deployment.

---

## ❓ Troubleshooting & FAQ

<details>
<summary><b>Q: The server logs say "[SyPB] Not Find Waypoint, Cannot Add SyPB". What should I do?</b></summary>
<p>
Make sure <code>sypb_download_waypoint 1</code> is set in <code>sypb.cfg</code> so the bot can fetch online waypoints, or verify that a <code>&lt;mapname&gt;.pwf</code> file exists in <code>cstrike/addons/sypb/wptdefault/</code>. You can also generate waypoints automatically by typing <code>sypb sgdwp on</code>.
</p>
</details>

<details>
<summary><b>Q: Bots join, but then immediately disappear or quota drops to 0.</b></summary>
<p>
Check your <code>cstrike/addons/amxmodx/configs/plugins.ini</code> for conflicting third-party plugins (e.g. <code>bot_controller.amxx</code> or custom scripts that execute <code>sypb_quota 0</code>). Disable any legacy bot management plugins, as SyPB-Linux handles its own quota and join lifecycle autonomously.
</p>
</details>

<details>
<summary><b>Q: Does SyPB-Linux support ReHLDS and ReGameDLL?</b></summary>
<p>
Yes! SyPB-Linux has been tested extensively against modern ReHLDS builds (v3.13+) and ReGameDLL. It also supports classic Half-Life Dedicated Server (HLDS) 1.1.2.7.
</p>
</details>

---

## 💬 Community & Support

Have questions, suggestions, or need help configuring SyPB for your server? Join our Discord community for support, waypoint sharing, and development updates!

<p align="center">
  <a href="https://sypb.netlify.app/"><img src="https://img.shields.io/badge/Website-sypb.netlify.app-00e5ff?style=flat-square&logo=netlify&logoColor=white" alt="Official Website"/></a>
  <a href="https://discord.gg/dB2HdnHasV">
    <img src="https://img.shields.io/badge/Discord-Join%20our%20Server-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Join Discord Server"/>
  </a>
</p>

- 🌐 **Official Website**: [https://sypb.netlify.app/](https://sypb.netlify.app/)
- 💬 **Discord Invite**: [https://discord.gg/dB2HdnHasV](https://discord.gg/dB2HdnHasV)

---

## 👥 Credits & Acknowledgments

- **SyPB Team & HsK-Dev Blog**: Original bot creators, core architecture, and waypoint algorithms.
- **EfeDursun125**: Heuristic search improvements and path matrix enhancements.
- **_unique_**: Linux porting, Metamod Linux interface hooks, memory management bug fixes, A* priority queue overhaul, and ReHLDS optimization.

---

## 📜 License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**. You are free to inspect, modify, and distribute the source code in accordance with the license conditions. See the [LICENSE](LICENSE) file for complete details.

<p align="center">
  <b>Built with ❤️ for the Counter-Strike 1.6 Community</b>
</p>
