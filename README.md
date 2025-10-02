Network Skins
=============

Mod for Cities: Skylines

[![Network Skins Logo](https://raw.githubusercontent.com/boformer/NetworkSkins/master/PreviewImage.png)](https://steamcommunity.com/sharedfiles/filedetails/?id=1758376843)

## Building

The mod is automatically built using GitHub Actions on every commit and release.

### Local Development

To build locally, you need:
1. Visual Studio 2019 or later (or JetBrains Rider)
2. .NET Framework 3.5 targeting pack
3. Cities: Skylines game assemblies (located at `C:\References\` by default)

Required assemblies:
- Assembly-CSharp.dll
- ColossalManaged.dll
- ICities.dll
- UnityEngine.dll

### Building with dotnet CLI

```bash
dotnet restore NetworkSkins.sln
dotnet build NetworkSkins/NetworkSkins.csproj -c Release
```

The compiled DLL will be in `NetworkSkins/bin/Release/net35/NetworkSkins.dll`

### Quick Build Scripts

For convenience, you can use the provided build scripts:

**Windows (PowerShell):**
```powershell
.\build-release.ps1 -Version "1.0.0"
```

**Linux/macOS (Bash):**
```bash
./build-release.sh 1.0.0
```

These scripts will:
- Build the project in Release mode
- Collect all necessary files
- Create a release ZIP archive

## Releases

Releases are automatically created when a version tag is pushed:

```bash
git tag v1.0.0
git push origin v1.0.0
```

The GitHub Actions workflow will:
1. Build the mod
2. Create a release archive
3. Publish it to GitHub Releases

## Installation

1. Download the latest release from [Releases](https://github.com/Caijiekai3018/NetworkSkins/releases)
2. Extract to: `%LOCALAPPDATA%\Colossal Order\Cities_Skylines\Addons\Mods\NetworkSkins`
3. Enable the mod in the game