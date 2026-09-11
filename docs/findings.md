# Findings

## Recovery Result

PhotoRec was used to recover deleted data from the FAT32 unallocated space of the forensic USB image.

At the completion of the recovery, PhotoRec reported:

```text
4096 files saved
```

The recovered files were stored in PhotoRec directories named `recup_dir.*`.

Recovery was performed from the forensic image rather than directly from the original USB device.

## Recovered File Analysis

The recovered data contained several different file types, including:

- PDF documents
- JPG images
- GIF images
- MP3 audio files
- TXT files
- TIFF images
- Microsoft Office documents
- Other miscellaneous file types

During later analysis, the recovered directories were searched specifically for PDF files.

The PDF count was:

```text
1762
```

This count was obtained during later analysis and is documented separately from PhotoRec's original report of 4,096 files saved.

## PDF Metadata Analysis

Many recovered PDFs had automatically generated PhotoRec filenames rather than their original filenames.

For example:

```text
f33303904.pdf
```

Despite the loss of the original filesystem filename, embedded PDF metadata was still present in many recovered documents.

A recovered PDF was examined using the macOS `mdls` utility:

```bash
mdls ./recup_dir.8/f33303904.pdf
```

Metadata recovered from this example included:

```text
Title: The Freemason's Monitor, Or, Illustrations of Masonry, in Two Parts
Author: Thomas Smith Webb
Pages: 339
Encoding software: Google Books PDF Converter
Security: Password Encrypted
PDF version: 1.7
```

This showed that embedded document metadata can provide useful information even when filesystem metadata and original filenames are unavailable.

## Metadata Catalog

A Bash script was created to automate the analysis of recovered PDF files.

The script searched the recovery directories for PDFs and extracted metadata using `mdls`.

The resulting CSV catalog contained:

```text
1762 PDF records
```

Metadata fields collected by the script included:

- File path
- Title
- Author
- Page count
- Encoding software
- Security information
- File size

The catalog made it possible to examine a large number of recovered documents without manually opening every PDF.

## Observations

Some recovered PDFs contained useful embedded metadata while others had missing metadata.

Some documents could be associated with known publications through their title and author metadata.

Encoding information also provided clues about the previous source or processing history of certain documents. For example, some recovered files identified Google Books PDF Converter as their encoding software.

Some recovered PDFs appeared complete, while others appeared to contain incomplete or damaged data. This is consistent with file carving, where the ability to reconstruct a deleted file depends on what data remains available.

## File Count Note

Two important counts were recorded during different stages of the investigation:

```text
PhotoRec completion result: 4096 files saved
PDF files found during later analysis: 1762
```

These figures describe different stages of the investigation and should not be treated as parts of the same file-type breakdown.

Additional file-extension counts were observed during later analysis. They are not used here to reconstruct the 4,096-file PhotoRec result because those later counts do not directly reconcile with PhotoRec's completion count.

## Conclusion

The investigation demonstrated that deleting files from a FAT32 USB drive does not necessarily immediately destroy the underlying file data.

By first creating a forensic image and performing recovery against that image, deleted data could be investigated without conducting the recovery directly on the original device.

PhotoRec successfully carved thousands of files from unallocated space. Although original filenames were often unavailable, embedded PDF metadata provided additional information about many recovered documents.

Automating the metadata extraction also demonstrated how scripting can assist a forensic investigation when a large number of recovered files must be examined and organised.
