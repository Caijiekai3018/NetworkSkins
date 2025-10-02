#!/bin/bash
# Bash script to build NetworkSkins and create a release package

VERSION="${1:-dev}"
OUTPUT_DIR="./release"

echo -e "\033[36mBuilding NetworkSkins v$VERSION...\033[0m"

# Clean previous build
echo -e "\033[33mCleaning previous builds...\033[0m"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Build the project
echo -e "\033[33mBuilding project...\033[0m"
dotnet build NetworkSkins/NetworkSkins.csproj -c Release

if [ $? -ne 0 ]; then
    echo -e "\033[31mBuild failed!\033[0m"
    exit 1
fi

# Copy files to release directory
echo -e "\033[33mCopying files to release directory...\033[0m"

BIN_PATH="NetworkSkins/bin/Release/net35"

# Copy main DLL
cp "$BIN_PATH/NetworkSkins.dll" "$OUTPUT_DIR/"

# Copy dependencies
if [ -f "$BIN_PATH/CitiesHarmony.API.dll" ]; then
    cp "$BIN_PATH/CitiesHarmony.API.dll" "$OUTPUT_DIR/"
fi

# Copy locale files
if [ -d "$BIN_PATH/Locale" ]; then
    cp -r "$BIN_PATH/Locale" "$OUTPUT_DIR/"
fi

# Create ZIP archive
ZIP_NAME="NetworkSkins-$VERSION.zip"
echo -e "\033[33mCreating archive: $ZIP_NAME...\033[0m"

rm -f "$ZIP_NAME"
cd "$OUTPUT_DIR"
zip -r "../$ZIP_NAME" *
cd ..

echo -e "\n\033[32mBuild complete!\033[0m"
echo -e "\033[32mRelease files are in: $OUTPUT_DIR\033[0m"
echo -e "\033[32mRelease archive: $ZIP_NAME\033[0m"

# Show file list
echo -e "\n\033[36mRelease contents:\033[0m"
find "$OUTPUT_DIR" -type f | while read file; do
    echo -e "\033[37m  ${file#./}\033[0m"
done
