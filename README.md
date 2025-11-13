# Guitar Rig Preset Fixer

Script to replace "Guitar Rig 4" with "Guitar Rig 6" in `.ngrr` preset files.

## Usage

```bash
./fix-guitar-rig.sh [directory]
```

If no directory specified, uses current directory.

## Example

```bash
./fix-guitar-rig.sh "/Users/faruk/Documents/Native Instruments/User Content/Guitar Rig 6"
```

## Features

- Recursively finds all `.ngrr` files
- Automatically creates `.backup` files
- Works with binary file formats
- Compatible with macOS and Linux

## Cleanup

Remove backups after verifying changes:

```bash
find [directory] -name "*.ngrr.backup" -exec rm {} \;
```
