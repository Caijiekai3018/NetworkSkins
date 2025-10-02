# Build and Release Setup Summary

This document summarizes the build and release automation setup for NetworkSkins.

## What Was Implemented

### 1. GitHub Actions Workflows

#### **build.yml** - Continuous Integration
- Triggers on: Push to master/main branch, Pull Requests
- Purpose: Validates that the code builds correctly
- Runs on: Windows (required for .NET 3.5 build)
- Actions:
  - Downloads Cities: Skylines game assemblies
  - Builds the project
  - Uploads build artifacts

#### **build-and-release.yml** - Release Automation
- Triggers on: Git tags (v*) or manual dispatch
- Purpose: Automatically creates releases
- Runs on: Windows
- Actions:
  - Downloads Cities: Skylines game assemblies
  - Builds the project in Release mode
  - Collects all necessary files (DLL, dependencies, locale files)
  - Creates a ZIP archive
  - Publishes to GitHub Releases with installation instructions

### 2. Local Build Scripts

#### **build-release.ps1** (Windows)
- PowerShell script for local builds
- Usage: `.\build-release.ps1 -Version "1.0.0"`
- Creates release folder and ZIP archive

#### **build-release.sh** (Linux/macOS)
- Bash script for local builds
- Usage: `./build-release.sh 1.0.0`
- Creates release folder and ZIP archive

### 3. Documentation

#### **README.md** (Updated)
- Added building instructions
- Added release process overview
- Added installation instructions
- Added information about build scripts

#### **.github/RELEASE.md**
- Detailed release process documentation
- Tag naming conventions
- Testing guidelines
- Post-release checklist

#### **.github/CONTRIBUTING.md**
- Contributing guidelines
- Development setup instructions
- Code style guidelines
- Pull request process

## How to Use

### Creating a Release

1. **Test your changes locally**
2. **Commit and push all changes**
3. **Create and push a version tag:**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. **GitHub Actions will automatically:**
   - Build the mod
   - Create a release
   - Upload the release package

### Manual Build

**Windows:**
```powershell
.\build-release.ps1 -Version "1.0.0"
```

**Linux/macOS:**
```bash
./build-release.sh 1.0.0
```

## Technical Details

### Game Assembly References

The workflows download Cities: Skylines assemblies from a public repository:
- Assembly-CSharp.dll
- ColossalManaged.dll
- ICities.dll
- UnityEngine.dll

These are required for compilation but not distributed with the mod.

### Build Output

The release package includes:
- `NetworkSkins.dll` - Main mod file
- `CitiesHarmony.API.dll` - Harmony dependency
- `Locale/*.xml` - Translation files (if present)

### Installation Location

The mod should be installed to:
```
%LOCALAPPDATA%\Colossal Order\Cities_Skylines\Addons\Mods\NetworkSkins
```

## Troubleshooting

### Build Fails in GitHub Actions
- Check if the game assembly URLs are still valid
- Verify the .NET version compatibility
- Review build logs in GitHub Actions tab

### Local Build Fails
- Ensure Cities: Skylines assemblies are at `C:\References\`
- Check .NET Framework 3.5 is installed
- Verify dotnet CLI is available

### Release Not Created
- Ensure tag starts with 'v' (e.g., v1.0.0)
- Check GITHUB_TOKEN permissions
- Review workflow logs

## Maintenance

### Updating Game Assembly Sources
If the assembly download URLs become unavailable, update them in:
- `.github/workflows/build.yml` (line ~29)
- `.github/workflows/build-and-release.yml` (line ~29)

### Updating Release Content
To modify what's included in releases, edit:
- `.github/workflows/build-and-release.yml` (lines 60-74)

## Future Improvements

Potential enhancements:
- [ ] Add automated testing
- [ ] Add changelog generation
- [ ] Add Steam Workshop upload automation
- [ ] Add mod compatibility checks
- [ ] Add version number auto-increment

## Questions?

For questions or issues with the build/release system, open an issue on GitHub.
