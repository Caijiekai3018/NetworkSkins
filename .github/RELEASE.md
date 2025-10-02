# Release Process

This document describes how to create a new release of NetworkSkins.

## Automatic Release via GitHub Actions

NetworkSkins uses GitHub Actions to automatically build and create releases.

### Creating a New Release

1. **Update version information** (if needed)
   - Update any version numbers in the code
   - Update CHANGELOG or release notes

2. **Create and push a version tag**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

3. **GitHub Actions will automatically:**
   - Build the mod with all dependencies
   - Create a release archive (NetworkSkins-Release.zip)
   - Publish the release to GitHub Releases
   - Include installation instructions

### Tag Naming Convention

Use semantic versioning for tags:
- `v1.0.0` - Major release
- `v1.1.0` - Minor release with new features
- `v1.1.1` - Patch release with bug fixes

### Release Contents

Each release includes:
- `NetworkSkins.dll` - Main mod file
- `CitiesHarmony.API.dll` - Harmony dependency
- Locale files (translation files)
- Installation instructions

## Manual Release (if needed)

If you need to create a release manually:

1. Build the project:
   ```bash
   dotnet build NetworkSkins/NetworkSkins.csproj -c Release
   ```

2. Collect files from `NetworkSkins/bin/Release/net35/`:
   - NetworkSkins.dll
   - CitiesHarmony.API.dll
   - Locale/*.xml

3. Create a zip file with these files

4. Create a GitHub release manually and upload the zip

## Testing Before Release

Before creating a release tag:
1. Test the mod in Cities: Skylines
2. Verify all features work correctly
3. Check compatibility with latest game version
4. Review closed issues and PRs for the release

## Post-Release

After a release is published:
1. Update Steam Workshop (if applicable)
2. Announce the release in community channels
3. Monitor for any issues or bug reports
