# Build & Release Architecture

This document describes the architecture of the build and release automation system.

## 🏗️ System Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                      NetworkSkins Repository                         │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
                    ▼                               ▼
        ┌────────────────────┐          ┌────────────────────┐
        │  Local Development │          │  GitHub Actions    │
        └────────────────────┘          └────────────────────┘
                    │                               │
        ┌───────────┴───────────┐       ┌──────────┴──────────┐
        │                       │       │                     │
        ▼                       ▼       ▼                     ▼
  ┌──────────┐          ┌──────────┐ ┌──────┐         ┌────────────┐
  │ Manual   │          │  IDE     │ │Build │         │  Release   │
  │ Scripts  │          │  Build   │ │ CI   │         │  Workflow  │
  └──────────┘          └──────────┘ └──────┘         └────────────┘
        │                       │       │                     │
        └───────────┬───────────┘       │                     │
                    ▼                   ▼                     ▼
            ┌──────────────┐    ┌────────────┐      ┌─────────────┐
            │  Local Build │    │  Build     │      │   GitHub    │
            │  Artifacts   │    │  Artifacts │      │   Releases  │
            └──────────────┘    └────────────┘      └─────────────┘
```

## 📋 Components

### 1. Local Development Path

```
Developer → IDE/Scripts → Build → Test → Commit
                              ↓
                    Local Mods Folder
                    (Auto-deployed)
```

**Tools:**
- `build-release.ps1` (Windows)
- `build-release.sh` (Linux/macOS)
- Visual Studio / Rider
- dotnet CLI

**Output:**
- Debug builds → Auto-deployed to local mods folder
- Release builds → `release/` folder + ZIP archive

### 2. Continuous Integration Path

```
Push to master/main → build.yml → Build → Artifacts
      (or PR)              ↓
                    Validate Build
```

**Triggers:**
- Push to master/main branch
- Pull requests

**Actions:**
1. Checkout code
2. Setup .NET 8.0
3. Download Cities: Skylines assemblies
4. Update project references
5. Restore dependencies
6. Build project
7. Upload artifacts

**Output:**
- Build validation
- Build artifacts (for inspection)

### 3. Release Automation Path

```
Push tag v* → build-and-release.yml → Build → Package → Release
                                           ↓
                                   GitHub Releases
                                           ↓
                                        Users
```

**Triggers:**
- Git tags matching `v*` (e.g., v1.0.0)
- Manual workflow dispatch

**Actions:**
1. Checkout code
2. Setup .NET 8.0
3. Download Cities: Skylines assemblies
4. Update project references
5. Restore dependencies
6. Build in Release mode
7. Collect files:
   - NetworkSkins.dll
   - CitiesHarmony.API.dll
   - Locale files
8. Create ZIP archive
9. Create GitHub Release
10. Upload release artifacts

**Output:**
- GitHub Release with:
  - NetworkSkins-Release.zip
  - Release notes
  - Installation instructions

## 🔄 Workflow Details

### Build Workflow (`build.yml`)

```yaml
Trigger: [push, pull_request]
  ↓
Setup Environment (Windows)
  ↓
Download Game Assemblies
  ↓
Update Project References
  ↓
Restore → Build → Test
  ↓
Upload Artifacts
```

### Release Workflow (`build-and-release.yml`)

```yaml
Trigger: [tag: v*, manual]
  ↓
Setup Environment (Windows)
  ↓
Download Game Assemblies
  ↓
Update Project References
  ↓
Restore → Build (Release)
  ↓
Prepare Release Files
  ↓
Create ZIP Archive
  ↓
Upload Artifacts
  ↓
Create GitHub Release
```

## 🔧 Technical Details

### Assembly Resolution

The workflows download required game assemblies from a public repository:

```
https://github.com/kianzarrin/UnifiedUI/raw/master/lib/
├── Assembly-CSharp.dll
├── ColossalManaged.dll
├── ICities.dll
└── UnityEngine.dll
```

During build, the project references are updated:
```powershell
C:\References\ → ${{ github.workspace }}\libs\
```

### Build Configuration

**Debug Configuration:**
- Used for local development
- Includes debug symbols
- Auto-deploys to local mods folder

**Release Configuration:**
- Used for releases
- No debug symbols
- Optimized build
- Ready for distribution

### File Structure

```
NetworkSkins/
├── .github/
│   ├── workflows/
│   │   ├── build.yml              # CI workflow
│   │   └── build-and-release.yml  # Release workflow
│   ├── ARCHITECTURE.md            # This file
│   ├── BUILD_AND_RELEASE_SETUP.md # Setup guide
│   ├── CONTRIBUTING.md            # Contribution guide
│   ├── QUICK_START.md             # Quick start
│   └── RELEASE.md                 # Release process
├── NetworkSkins/
│   ├── NetworkSkins.csproj        # Project file
│   └── ...                        # Source code
├── build-release.ps1              # Build script (Windows)
├── build-release.sh               # Build script (Unix)
└── README.md                      # Main documentation
```

## 🚀 Release Flow

```
1. Developer                    2. GitHub Actions              3. Users
   ↓                               ↓                            ↓
git tag v1.0.0              Detect tag push              Browse Releases
   ↓                               ↓                            ↓
git push origin v1.0.0      Trigger workflow            Find latest release
                                   ↓                            ↓
                            Download assemblies         Download ZIP
                                   ↓                            ↓
                            Build project               Extract to mods folder
                                   ↓                            ↓
                            Package files               Enable in game
                                   ↓                            ↓
                            Create release              Enjoy!
                                   ↓
                            Notify watchers
```

## 📊 Dependencies

### Build Dependencies
- .NET Framework 3.5
- Cities: Skylines assemblies (downloaded automatically)
- CitiesHarmony.API (NuGet package)

### Runtime Dependencies
- Cities: Skylines game
- CitiesHarmony mod (installed separately)

## 🔐 Security Considerations

- Game assemblies are downloaded from trusted public sources
- No secrets or credentials are stored in the repository
- GITHUB_TOKEN is provided automatically by GitHub Actions
- All builds are reproducible and transparent

## 🔍 Monitoring

**Build Status:**
- Check the Actions tab in GitHub
- Each commit shows build status
- Failed builds prevent releases

**Release Status:**
- Releases appear in the Releases page
- Each release includes:
  - Version number
  - Release notes
  - Download links
  - Installation instructions

## 📝 Maintenance

### Updating Assembly Sources
If download URLs change, update in:
- `.github/workflows/build.yml` (line ~29-33)
- `.github/workflows/build-and-release.yml` (line ~29-33)

### Updating Build Process
To modify the build process, edit:
- `.github/workflows/build-and-release.yml` (lines 54-74)

### Version Management
Versions are managed through Git tags:
- Format: `vMAJOR.MINOR.PATCH`
- Example: `v1.2.3`

## 🎯 Best Practices

1. **Always test locally before releasing**
2. **Use semantic versioning for tags**
3. **Keep documentation up to date**
4. **Review Actions logs for issues**
5. **Test in-game before tagging**

## 🆘 Troubleshooting

### Build Fails
1. Check Actions logs
2. Verify assembly URLs
3. Check .NET version compatibility

### Release Not Created
1. Verify tag format (must start with 'v')
2. Check workflow permissions
3. Review workflow logs

### Local Build Issues
1. Verify game assemblies location
2. Check .NET Framework 3.5 installation
3. Ensure dotnet CLI is available

---

For more information, see:
- [Quick Start Guide](QUICK_START.md)
- [Release Process](RELEASE.md)
- [Build Setup](BUILD_AND_RELEASE_SETUP.md)
