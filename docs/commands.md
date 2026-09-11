# USB Recovery Command Log

This document records the commands and important recovery steps used during the USB forensic recovery project.

## 1. Identify the USB Device

The connected disks were listed using:

```bash
diskutil list
```

The USB was identified as an external physical disk:

```text
/dev/disk2
```

The device contained a FAT32 partition:

```text
/dev/disk2s1
```

The USB had a capacity of approximately 31.3 GB.

## 2. Unmount the USB

Before imaging, the USB was unmounted:

```bash
diskutil unmountDisk /dev/disk2
```

This prevented normal filesystem access while keeping the physical device available for imaging.

## 3. Create the Forensic Image

A bit-for-bit image of the USB was created using `dd`:

```bash
sudo dd if=/dev/rdisk2 of=transcend_usb.img bs=4m
```

The resulting forensic image was:

```text
transcend_usb.img
```

The completed `dd` operation reported:

```text
22057844736 bytes transferred
```

The forensic image occupied approximately 29 GB on disk.

All subsequent recovery work was performed on this image rather than directly on the original USB.

## 4. Inspect the Forensic Image

The image size was checked using:

```bash
ls -lh transcend_usb.img
```

The image structure was inspected using:

```bash
file transcend_usb.img
```

The output identified a DOS/MBR boot sector and a FAT partition.

## 5. Verify Image Integrity

A SHA-256 hash of the forensic image was calculated using:

```bash
shasum -a 256 transcend_usb.img
```

The resulting SHA-256 hash was:

```text
3fa0da06b698e1b2355c20d5854ee36e9bf4eb9719ab4873b59ca8201d128a85
```

This hash provides an integrity reference for the forensic image used during the investigation.

## 6. Recover Deleted Files with PhotoRec

PhotoRec was launched against the forensic image:

```bash
sudo photorec transcend_usb.img
```

Inside PhotoRec, the FAT32 partition was selected.

The filesystem type was set to:

```text
Other
```

The recovery mode was set to:

```text
Free
```

Selecting `Free` instructed PhotoRec to search the unallocated FAT32 space for deleted data.

Recovered files were written to PhotoRec recovery directories named:

```text
recup_dir.*
```

At the completion of the recovery, PhotoRec reported:

```text
4096 files saved
```

This is the file count reported by the PhotoRec recovery operation.

## 7. Count Recovered PDF Files

During later analysis, recovered PDF files were counted using:

```bash
find . -type f -name '*.pdf' | wc -l
```

The result was:

```text
1762
```

The 1,762 figure represents the number of PDF files found during the later analysis. It is separate from PhotoRec's completion message reporting 4,096 files saved.

## 8. Inspect Recovered PDF Metadata

Recovered files had generated PhotoRec filenames such as:

```text
f33303904.pdf
```

The metadata of this recovered PDF was inspected using:

```bash
mdls ./recup_dir.8/f33303904.pdf
```

The metadata showed information including:

```text
Title: The Freemason's Monitor, Or, Illustrations of Masonry, in Two Parts
Author: Thomas Smith Webb
Pages: 339
Encoding software: Google Books PDF Converter
Security: Password Encrypted
PDF version: 1.7
```

This demonstrated that useful embedded document metadata could survive even when the original filesystem filename was no longer available.

## 9. Automated PDF Cataloguing

A Bash script named:

```text
make_catalog.sh
```

was created to automate metadata extraction from recovered PDF files.

The script searches for PDFs and uses the macOS `mdls` utility to extract metadata including:

- File path
- Title
- Author
- Number of pages
- Encoding software
- Security information
- File size

The results were written to:

```text
PDF_Catalog.csv
```

The resulting catalog contained:

```text
1762 PDF records
```

## Important Note About File Counts

PhotoRec reported 4,096 files saved when the recovery operation completed.

During later analysis, 1,762 PDF files were found in the recovery data.

Additional extension counts were also observed during later analysis, but those counts are not presented here as components of the 4,096-file PhotoRec result because they were collected separately and do not reconcile directly with PhotoRec's completion count.

For that reason, the two verified figures documented here are:

```text
PhotoRec recovery result: 4096 files saved
PDF files found during later analysis: 1762
```
