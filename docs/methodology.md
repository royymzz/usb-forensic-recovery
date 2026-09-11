# Methodology

## Device Identification

The USB device was identified using:

```bash
diskutil list
diskutil unmountDisk /dev/disk2
sudo dd if=/dev/rdisk2 of=transcend_usb.img bs=4m
shasum -a 256 transcend_usb.img
f33303904.pdf
mdls file.pdf

Then check it:

```bash
cat docs/methodology.md
