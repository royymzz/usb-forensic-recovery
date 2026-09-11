# USB Forensic Recovery

A digital forensics project focused on recovering deleted data from a FAT32 USB drive and analysing the recovered files.

## Overview

The goal of this project was to recover files that had been deleted from an old USB drive several years ago while preserving the original device.

The investigation included:

- Identifying and imaging the USB drive
- Creating a SHA-256 hash of the forensic image
- Recovering deleted files with PhotoRec
- Analysing recovered PDF metadata
- Creating a Bash script to automatically catalogue recovered PDFs

## Tools Used

- macOS Terminal
- `diskutil`
- `dd`
- `shasum`
- TestDisk / PhotoRec
- `mdls`
- Bash

## Recovery

A bit-for-bit image of the USB was created before performing recovery.

PhotoRec was then used on the image to recover deleted data from FAT32 unallocated space.

The recovery produced several file types, including:

- PDF
- JPG
- GIF
- MP3
- TXT
- TIFF
- Microsoft Office files

A total of 1,762 PDF files were identified in the recovered data.

## PDF Metadata Analysis

PhotoRec recovered many PDFs with generated filenames such as:

```text
f33303904.pdf
```

Although the original filenames were unavailable, some PDFs still contained embedded metadata such as:

- Title
- Author
- Number of pages
- Encoding software
- Security information

A Bash script was created to extract this information using `mdls` and save the results into a CSV catalog.

The script is available in:

```text
scripts/make_catalog.sh
```

## Evidence Handling

Recovery and analysis were performed on a forensic image rather than directly on the original USB device.

Recovered personal files and the forensic image are not included in this repository.

## Documentation

A more detailed description of the process is available in:

```text
docs/methodology.md
```
## Project Documentation

- [Methodology](docs/methodology.md)
- [Recovery Findings](docs/findings.md)
