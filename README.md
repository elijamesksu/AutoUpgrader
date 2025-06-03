# SevenZipAutoUpdater for Intune

This project automates the detection, uninstallation, and installation of the latest version of [7-Zip](https://www.7-zip.org) using Microsoft Intune's Win32 app model.

## What It Does

- Scrapes the latest version of 7-Zip from the official website
- Uninstalls existing versions using the native uninstaller
- Cleans up leftover folders
- Downloads and installs the latest `.msi` silently
- Can be deployed through Microsoft Intune with a custom detection script



## File Breakdown

| File | Description |
|------|-------------|
| `Install-7Zip.ps1` | Main installer script (used in `.intunewin` package) |
| `Detect-7Zip.ps1`  | Detection script to verify if latest version is already installed |
| `Source/`          | Folder where packaging source is built |
| `Install-7Zip.intunewin` | Output package for Intune (not uploaded here) |



## Intune Deployment Instructions

1. Package `Install-7Zip.ps1` using [IntuneWinAppUtil.exe](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool)
2. Upload `.intunewin` file to Intune as a **Win32 app**
3. Use `Detect-7Zip.ps1` as a **custom detection rule**
4. Assign to devices or user groups



## Detection Script Logic

The detection script:
- Pulls the latest version from the 7-Zip website
- Compares to the installed registry version
- Exits with `0` if latest is installed, `1` if not


## License

MIT License
