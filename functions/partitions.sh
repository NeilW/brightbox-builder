#!/bin/sh

## live-build(7) - System Build Scripts
## Copyright (C) 2006-2011 Daniel Baumann <daniel@debian.org>
##
## live-build comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
## This is free software, and you are welcome to redistribute it
## under certain conditions; see COPYING for details.


Check_mapped_partitions()
{
  export ROOT_PARTITION_DEVICE=$(ls -r /dev/mapper/loop*p1 | head -1)
  MAIN_DISK=${ROOT_PARTITION_DEVICE#/dev/mapper/}
  export MAIN_DISK=/dev/${MAIN_DISK%p1}
  export TARGET_PARTITION=chroot/binary.tmp
  Report_mapping
}

Set_partition_variables()
{
  export ROOT_PARTITION_DEVICE="/dev/mapper/$3"
  export MAIN_DISK="$8"
  export TARGET_PARTITION=chroot/binary.tmp
  Report_mapping
}

Report_mapping()
{
  Echo_message "Main disk on device ${MAIN_DISK}"
  Echo_message "Root partition on device ${ROOT_PARTITION_DEVICE}"
}

Setup_partitions()
{
  Set_partition_variables $(${LB_ROOT_COMMAND} kpartx -av "$1")
}

Remove_partitions()
{
  ${LB_ROOT_COMMAND} kpartx -dv "$1"
  unset ROOT_PARTITION_DEVICE MAIN_DISK
}

