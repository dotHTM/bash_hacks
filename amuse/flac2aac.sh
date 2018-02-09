#!/usr/local/bin/bash

for i in *flac; do
	of="${i/.flac/.m4a}";
	ffmpeg -i "${i}" -vn -acodec aac -b:a 320k -f mp4 -y "${of}";
done

