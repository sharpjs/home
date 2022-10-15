# Journal Warnings & Errors
...and what to do about them.

## AMD-Vi INVALID_DEVICE_REQUEST

```
kernel: iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
```

Action: Ignore.

PCI device `00:00.0` (AMD Root Complex) attempted to write to address
`FFFF_FFFF_FFFD_F800_0000`, which is the start of the IOMMU's Interrupt/EOI
address space.  Access to this address space is controlled by the IOMMU device
table entry's `IntCtl` field.  The value of the field was `0`, which specifies
that requests should be aborted.

From _AMD I/O Virtualization Technology (IOMMU) Specification_:

> If the IOMMU receives a request from a device that the device is not allowed
> to perform, the IOMMU writes the event log with a INVALID_DEVICE_REQUEST
> event

Specifically, `flags=0x0a00` specifies:

> Posted write to the Interrupt/EOI range from an I/O device that has
> IntCtl=00b in the device’s DTE.

The Interrupt/EOI range is a special address range apparently used for data
packets that communicate interrupt requests and end-of-interrupt notifications.

> Accesses to the interrupt address range ... are defined to go through the
> interrupt remapping portion of the IOMMU and not through [virtual] address
> translation processing.

Experienced with MSI MEG X399 CREATION motherboard.

## missing or invalid SUBNQN field

```
nvme nvme1: missing or invalid SUBNQN field.
```

Action: Ignore.

This is an inconsequential shortcoming of the SSD firmware.  Linux compensates
by generating a fake SUBNQN to use instead.  Can be suppressed by kernel config
NVME_QUIRK_IGNORE_DEV_SUBNQN.

Experienced with Samsung 970 Pro.  Also reported on other Samsung SSD.

## Trusted Memory Zone feature not supported

```
kernel: amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
```

Action: Ignore.

The Trusted Memory Zone (TMZ) feature enables encryption of VRAM.  The feature
is supported starting with Raven, Renoir, and Navi GPUs.  Since my GPU is from
a previous generation (Polaris), it does not support the feature.  It is
unknown what actual benefit the TMZ feature would provide.

Experienced with AMD Radeon RX 580.

## Using highest water mark set.

```
amdgpu: Clock is not in range of specified clock range for watermark from DAL!  Using highest water mark set.
```

Action: Ignore for now.

Experienced with AMD Radeon RX 580.

## MSFT0101 Firmware Bug

```
kernel: tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does not cover the entire command/response buffer. [mem 0x79ce8000-0x79ce8fff flags 0x200] vs 79ce8000 4000
kernel: tpm_crb MSFT0101:00: can't request region for resource [mem 0x79ce8000-0x79ce8fff]
kernel: tpm_crb: probe of MSFT0101:00 failed with error -16
```

Action: Ignore or disable TPM.

The motherboard's ACPI and/or TPM implementation is buggy.
https://unix.stackexchange.com/questions/422454/acpi-region-does-not-cover-the-entire-command-response-buffer
https://patchwork.kernel.org/project/linux-integrity/patch/20190830095639.4562-3-kkamagui@gmail.com/

Experienced with MSI MEG X399 CREATION motherboard.

## set-wireless-regdom failed

```
cfg80211: Process '/usr/bin/set-wireless-regdom' failed with exit code 1
```

Action: `sudo vim /etc/conf.d/wireless-regdom` and uncomment the appropriate
country code.

## Failed to read out thermal zone

```
thermal thermal_zone0: failed to read out thermal zone (-61)
```

Action: uknown.

Possibly this bug:
https://bugzilla.kernel.org/show_bug.cgi?id=201761

