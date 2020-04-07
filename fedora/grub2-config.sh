#!/usr/bin/bash

opts='rd.luks.uuid=luks-aa2d1119-9425-46e3-ab97-0aa82f97c3be'
opts+=' rd.lvm.lv=fedora/root'
opts+=' rd.lvm.lv=fedora/swap'
opts+=' root=/dev/mapper/fedora-root'
opts+=' resume=/dev/mapper/fedora-swap'
opts+=' btusb.enable_autosuspend=0'
opts+=' ro'
opts+=' rhgb'
opts+=' quiet'

grub2-editenv - set   kernelopts="$opts"
grub2-editenv - set   menu_auto_hide=2
grub2-editenv - set   boot_success=1
grub2-editenv - unset boot_indeterminate
grub2-editenv - list

