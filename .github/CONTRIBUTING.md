# Contributing to NetworkSkins

Thank you for your interest in contributing to NetworkSkins!

## Development Setup

### Prerequisites

1. **IDE**: Visual Studio 2019+ or JetBrains Rider
2. **.NET**: .NET Framework 3.5 targeting pack
3. **Game Assemblies**: Cities: Skylines game DLLs

### Game Assembly References

The project requires these assemblies from Cities: Skylines:
- Assembly-CSharp.dll
- ColossalManaged.dll
- ICities.dll
- UnityEngine.dll

Place them in `C:\References\` or update the paths in `NetworkSkins.csproj`.

You can find these in your Cities: Skylines installation directory:
```
Steam\steamapps\common\Cities_Skylines\Cities_Data\Managed\
```

### Building

```bash
dotnet restore NetworkSkins.sln
dotnet build NetworkSkins/NetworkSkins.csproj -c Debug
```

The mod will be automatically copied to your local mods folder after build (see `DeployToModDirectory` target in the .csproj).

## Making Changes

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/my-feature`
3. **Make your changes**
4. **Test thoroughly** in Cities: Skylines
5. **Commit with clear messages**: `git commit -m "Add feature X"`
6. **Push to your fork**: `git push origin feature/my-feature`
7. **Create a Pull Request**

## Code Style

- Follow the existing code style in the project
- Use meaningful variable and method names
- Add comments for complex logic
- Keep methods focused and concise

## Testing

- Test your changes in-game before submitting
- Verify compatibility with common mods
- Check for performance issues
- Test with different network types

## Pull Request Process

1. Update README.md if you add features
2. Ensure the build passes
3. Describe your changes clearly in the PR description
4. Link any related issues
5. Be responsive to review feedback

## Reporting Issues

When reporting issues:
- Use a clear, descriptive title
- Describe the expected behavior
- Describe the actual behavior
- List steps to reproduce
- Include game version and mod version
- List other active mods (if relevant)
- Attach logs if available

## Questions?

Feel free to open an issue for questions or discussions.

Thank you for contributing! 🎉
