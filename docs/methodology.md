# Methodology

## 1. Device Identification

The USB device was first identified using:

```bash
diskutil list
```

The device was identified as `/dev/disk2`, with a FAT32 partition at `/dev/disk2s1` and a capacity of approximately 31.3 GB.

## 2. Evidence Preservation

Before imaging, the USB was unmounted:

```bash
diskutil unmountDisk /dev/disk2
```

The original USB was not used for the subsequent recovery process. Instead, recovery and analysis were performed on a forensic image.

## 3. Forensic Imaging

A bit-for-bit image of the USB was created using `dd`:

```bash
sudo dd if=/dev/rdisk2 of=transcend_usb.img bs=4m
```

The completed imaging operation reported:

```text
22057844736 bytes transferred
```

The resulting forensic image was approximately 29 GB on disk.

## 4. Image Examination

The forensic image was inspected to verify its structure:

```bash
file transcend_usb.img
```

The output identified a DOS/MBR boot sector and FAT partition structure.

## 5. Integrity Verification

A SHA-256 hash was calculated for the forensic image:

```bash
shasum -a 256 transcend_usb.img
```

The resulting hash was:

```text
3fa0da06b698e1b2355c20d5854ee36e9bf4eb9719ab4873b59ca8201d128a85
```

This hash provides an integrity reference for the forensic image used during the investigation.

## 6. Deleted File Recovery

PhotoRec was used to recover deleted files from the forensic image:

```bash
sudo photorec transcend_usb.img
```

The FAT32 partition was selected in PhotoRec.

The filesystem type was set to `Other`, and the `Free` option was selected so that PhotoRec searched the unallocated FAT32 space for deleted data.

Recovered files were written to `recup_dir.*` directories.

At the completion of the recovery, PhotoRec reported:

```text
4096 files saved
```

## 7. Recovered File Analysis

The recovered files were then examined by file type.

During later analysis, the number of recovered PDF files was counted using:

```bash
find . -type f -name '*.pdf' | wc -l
```

The result was:

```text
1762
```

This PDF count was collected during later analysis and is separate from PhotoRec's completion report of 4,096 files saved.

## 8. PDF Metadata Analysis

PhotoRec assigned generated filenames to recovered files, such as:

```text
f33303904.pdf
```

A recovered PDF was examined using the macOS metadata utility `mdls`:

```bash
mdls ./recup_dir.8/f33303904.pdf
```

The available metadata included information such as title, author, number of pages, encoding software and security information.

For the example above, the metadata identified the document as *The Freemason's Monitor, Or, Illustrations of Masonry, in Two Parts* by Thomas Smith Webb.

## 9. Automated Cataloguing

Manually examining 1,762 recovered PDFs would be inefficient, so a Bash script was created to automate the process.

The script searches for recovered PDF files and uses `mdls` to extract:

- File path
- Title
- Author
- Page count
- Encoding software
- Security information
- File size

The extracted information was written to:

```text
PDF_Catalog.csv
```

The resulting catalog contained 1,762 PDF records.

## 10. Evidence Handling

The original USB was preserved by performing recovery and analysis against the forensic image rather than directly against the physical device.

The forensic image and recovered personal files are not included in this repository.

Only documentation, analysis methodology, code and sanitized examples are intended to be published.
