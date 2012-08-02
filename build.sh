#!/bin/bash
DEVICES="fascinatemtd mesmerizemtd showcasemtd"
. build/envsetup.sh

DoIt() {
	brunch "$1" || exit 1
}

Impregnate() {
	cp out/target/product/"$1"/cm-10-*.zip ~/Dropbox/Public || exit 1
}

GTFO() {
	rm -rf out
}

MakeBabies() {
	DoIt "$1" && Impregnate "$1" && GTFO
}

GTFO
if [ ! "$1" ]; then
	for x in $DEVICES
	do
		MakeBabies "$x"
	done
else
	MakeBabies "$1"
fi

