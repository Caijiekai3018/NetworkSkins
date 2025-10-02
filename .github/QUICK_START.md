# Quick Start Guide

This guide will help you get started with building and releasing NetworkSkins.

## 🚀 For Users

### Download and Install

1. Go to [Releases](https://github.com/Caijiekai3018/NetworkSkins/releases)
2. Download the latest `NetworkSkins-Release.zip`
3. Extract to: `%LOCALAPPDATA%\Colossal Order\Cities_Skylines\Addons\Mods\NetworkSkins`
4. Launch Cities: Skylines and enable the mod

## 👨‍💻 For Developers

### First Time Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Caijiekai3018/NetworkSkins.git
   cd NetworkSkins
   ```

2. **Install prerequisites:**
   - Visual Studio 2019+ or JetBrains Rider
   - .NET Framework 3.5 targeting pack
   - Cities: Skylines game assemblies (place in `C:\References\`)

3. **Build the project:**
   ```bash
   dotnet restore
   dotnet build NetworkSkins/NetworkSkins.csproj -c Debug
   ```

### Making Changes

1. **Create a branch:**
   ```bash
   git checkout -b feature/my-feature
   ```

2. **Make your changes and test in-game**

3. **Build a release package:**
   
   **Windows:**
   ```powershell
   .\build-release.ps1
   ```
   
   **Linux/macOS:**
   ```bash
   ./build-release.sh
   ```

4. **Commit and push:**
   ```bash
   git add .
   git commit -m "Description of changes"
   git push origin feature/my-feature
   ```

5. **Create a Pull Request on GitHub**

## 📦 Creating a Release

### Automatic Release (Recommended)

1. **Ensure all changes are committed and pushed to master**

2. **Create and push a version tag:**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

3. **Done!** GitHub Actions will automatically:
   - Build the mod
   - Create a release archive
   - Publish to GitHub Releases

### Manual Release

If you need to build manually:

```bash
# Windows
.\build-release.ps1 -Version "1.0.0"

# Linux/macOS
./build-release.sh 1.0.0
```

Then manually create a GitHub release and upload the ZIP file.

## 🔧 Build Status

The project uses GitHub Actions for CI/CD:

- **Build workflow**: Runs on every commit to validate builds
- **Release workflow**: Runs on version tags to create releases

Check the [Actions tab](../../actions) to see build status.

## 📚 More Information

- [Contributing Guidelines](CONTRIBUTING.md)
- [Release Process](RELEASE.md)
- [Build & Release Setup](BUILD_AND_RELEASE_SETUP.md)
- [Main README](../README.md)

## ❓ Need Help?

- Check existing [Issues](../../issues)
- Create a new issue if you need help
- Read the documentation files in `.github/`

## 🎯 Common Tasks

### Test your changes locally
```bash
dotnet build NetworkSkins/NetworkSkins.csproj -c Debug
# The mod will auto-deploy to your local mods folder
```

### Create a release build
```bash
.\build-release.ps1  # Windows
./build-release.sh   # Linux/macOS
```

### Update dependencies
```bash
dotnet restore --force
```

### Clean build artifacts
```bash
dotnet clean
```

---

**Happy modding! 🎮**
