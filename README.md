# USB Forensic Recovery

A digital forensics project focused on recovering deleted data from a FAT32 USB drive while preserving the original device and analysing the recovered files.

## Overview

The goal of this project was to investigate an old USB drive containing files that had been deleted several years earlier.

Instead of performing recovery directly on the original device, a bit-for-bit forensic image was created and used for the investigation.

The project included:

- Identifying and unmounting the USB device
- Creating a bit-for-bit forensic image
- Calculating a SHA-256 hash of the image
- Recovering deleted files with PhotoRec
- Examining recovered file types
- Analysing embedded PDF metadata
- Creating a Bash script to catalogue recovered PDFs automatically

## Forensic Workflow

The USB was identified as a FAT32 device with a capacity of approximately 31.3 GB.

A forensic image was created using `dd`:

```bash
sudo dd if=/dev/rdisk2 of=transcend_usb.img bs=4m
```

A SHA-256 hash was then calculated:

```text
3fa0da06b698e1b2355c20d5854ee36e9bf4eb9719ab4873b59ca8201d128a85
```

PhotoRec was run against the forensic image rather than the original USB.

The FAT32 partition and `Free` recovery option were selected so that PhotoRec searched unallocated space for deleted data.

At completion, PhotoRec reported:

```text
4096 files saved
```

## Recovered Data

The recovered data contained several file types, including:

- PDF
- JPG
- GIF
- MP3
- TXT
- TIFF
- Microsoft Office documents
- Other miscellaneous files

During later analysis, the recovery directories were searched specifically for PDF files.

```text
1762 PDF files
```

The 1,762 PDF count was obtained during later analysis and is separate from PhotoRec's completion report of 4,096 files saved.

## PDF Metadata Analysis

Many recovered files had generated PhotoRec filenames such as:

```text
f33303904.pdf
```

Although original filenames were often unavailable, embedded PDF metadata remained accessible in many files.

The macOS `mdls` utility was used to examine information including:

- Document title
- Author
- Number of pages
- Encoding software
- Security information
- File size

A Bash script was then created to automate this process across the recovered PDF collection and save the results to a CSV catalog.

## Tools Used

- macOS Terminal
- `diskutil`
- `dd`
- `shasum`
- TestDisk / PhotoRec
- `mdls`
- Bash

## Project Structure

```text
usb-forensic-recovery/
├── README.md
├── docs/
│   ├── commands.md
│   ├── findings.md
│   └── methodology.md
├── samples/
│   └── catalog_sample.csv
└── scripts/
    └── make_catalog.sh
```

## Documentation

- [Methodology](docs/methodology.md) - forensic acquisition, recovery and analysis methodology
- [Command Log](docs/commands.md) - commands and recovery steps used during the investigation
- [Recovery Findings](docs/findings.md) - results and observations from the recovered data

## Scripts

The metadata cataloguing script is available here:

- [make_catalog.sh](scripts/make_catalog.sh)

The script uses the macOS `mdls` utility and is therefore intended for macOS.

## Sample Output

A sanitized example of the CSV structure produced by the metadata cataloguing process is included here:

- [catalog_sample.csv](samples/catalog_sample.csv)

The sample contains example data and does not contain recovered personal files or private information.

## Evidence Handling and Privacy

Recovery and analysis were performed against a forensic image rather than directly against the original USB device.

The following are intentionally excluded from this repository:

- The forensic USB image
- Recovered personal files
- Original recovered PDFs and documents
- Private or identifying information

Only documentation, code and sanitized example data are included.

## Key Results

```text
USB filesystem:             FAT32
USB capacity:               ~31.3 GB
Forensic image:             ~29 GB
PhotoRec completion result: 4096 files saved
PDFs found in later analysis: 1762
Metadata catalog records:   1762
Hash algorithm:             SHA-256
```

This project demonstrates a basic forensic workflow covering evidence preservation, forensic imaging, integrity verification, file carving, metadata analysis and automated evidence cataloguing.
