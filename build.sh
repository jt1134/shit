#!/bin/bash
startTime=`date`
DEVICES="fascinatemtd"
. build/envsetup.sh

DoIt() {
	brunch "$@" || exit 1
}

Impregnate() {
	cp out/target/product/"$@"/cm-10.1-*.zip ~/Dropbox/Public || exit 1
}

GTFO() {
	rm -rf out/target
}

MakeBabies() {
	DoIt "$@" && Impregnate "$@" && GTFO
}

rm -rf out
if [ ! "$1" ]; then
	for x in $DEVICES
	do
		MakeBabies "$x"
	done
else
	MakeBabies "$1"
fi

echo
echo "Start Time : $startTime"
echo "End Time   : `date`"

