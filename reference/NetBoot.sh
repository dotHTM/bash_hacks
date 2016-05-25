#!/bin/sh

server=""
sharepoint=""
setName=""
imageName=""
protocol="NFS"
simple="true"
nextboot="--nextonly"

if [ $simple == true ]; then
	/usr/sbin/bless --netboot --server "bsdp://${server}" $nextboot
else
	/usr/sbin/bless --netboot --booter "tftp://${server}/NetBoot/${sharepoint}/${setName}/i386/booter" --kernel "tftp://${server}/NetBoot/${sharepoint}/${setName}/i386/mach.macosx" --options "rp=${protocol}:${server}:/private/tftpboot/NetBoot/${sharepoint}:${setName}/${imageName}" $nextboot
fi
