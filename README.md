# ConfigMgr OSD Script Hub (archived)

> **Hub moved:** The public landing page is now maintained at
> [vartaxe.github.io](https://vartaxe.github.io/). This repository is retained
> read-only for history and provenance; the individual script repositories remain
> the authoritative sources for code, documentation, tests, releases, and checksums.

[![CI](https://github.com/vartaxe/ConfigMgr-OSD/actions/workflows/ci.yml/badge.svg)](https://github.com/vartaxe/ConfigMgr-OSD/actions/workflows/ci.yml) ![PowerShell 5.1](https://img.shields.io/badge/PowerShell-5.1-blue) [![License](https://img.shields.io/github/license/vartaxe/ConfigMgr-OSD)](LICENSE)

[Website](https://vartaxe.github.io/ConfigMgr-OSD/)

<p align="center"><picture><source media="(max-width: 720px)" srcset="assets/banner-compact.svg?v=1.0.0" width="640"><img src="assets/banner.svg?v=1.0.0" alt="ConfigMgr OSD script hub banner" width="1280" height="320"></picture></p>

PowerShell 5.1 scripts for Configuration Manager operating system deployment (OSD) task sequences, each in its own repository with tests, docs and a project site.

## Scripts

| Script | Purpose | Repository | Site |
| --- | --- | --- | --- |
| AddComputerToADGroup | Add the computer to an Active Directory group during OSD | [Source](https://github.com/vartaxe/ConfigMgr-OSD-AddComputerToADGroup) | [Docs](https://vartaxe.github.io/ConfigMgr-OSD-AddComputerToADGroup/) |
| CopyOSDLogToFileShare | Upload OSD logs to an SMB file share | [Source](https://github.com/vartaxe/ConfigMgr-OSD-CopyOSDLogToFileShare) | [Docs](https://vartaxe.github.io/ConfigMgr-OSD-CopyOSDLogToFileShare/) |
| DiskPartitionLayout | UEFI/GPT or BIOS/MBR partitioning in WinPE | [Source](https://github.com/vartaxe/ConfigMgr-OSD-DiskPartitionLayout) | [Docs](https://vartaxe.github.io/ConfigMgr-OSD-DiskPartitionLayout/) |

> **Warning:** DiskPartitionLayout irreversibly cleans and repartitions disks. It is not field-certified. Live ConfigMgr, Active Directory, WinPE and SMB testing is still pending for all scripts; validate in a lab first.

Maintained by [Claudio Mendes](https://github.com/vartaxe). See the [profile](https://vartaxe.github.io/vartaxe/) for more projects.