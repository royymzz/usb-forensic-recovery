# Findings

## Recovery Results

PhotoRec recovered several thousand files from FAT32 unallocated space.

The recovered file types included:

- 1,762 PDF files
- 1,127 JPG images
- 1,032 GIF images
- 224 MP3 files
- 161 text files
- 107 TIFF images
- Microsoft Office documents
- Other miscellaneous file types

## PDF Analysis

Many recovered PDFs had generated filenames because the original filesystem metadata was no longer available.

For example:

`f33303904.pdf`

Embedded PDF metadata was still available in many files. This made it possible to recover information such as document title, author, page count, PDF creation software and security settings.

Some recovered PDFs were complete while others appeared to be damaged or partial files.

## Metadata Catalog

A Bash script was used to process the recovered PDFs automatically.

The script extracted metadata using `mdls` and created a CSV catalog containing information about 1,762 PDFs.

The metadata also provided clues about the possible origin of some files. For example, some PDFs identified Google Books PDF Converter as their encoding software.

## Conclusion

The recovery demonstrated that deleting files does not necessarily remove their underlying data immediately.

Even when original filenames and filesystem metadata were lost, file carving and embedded document metadata allowed useful information to be recovered and organised.
