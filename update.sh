#!/bin/bash

cd $(dirname $0)"/../"
HOME=$(pwd)

REPOS="bionic \
       build \
       external/chromium \
       external/dnsmasq \
       external/e2fsprogs \
       external/lsof \
       external/openssl \
       external/openssh \
       external/openvpn \
       external/oprofile \
       external/ping \
       external/skia \
       external/stlport \
       external/v8 \
       external/webkit \
       external/wpa_supplicant_8 \
       frameworks/av \
       frameworks/base \
       frameworks/ex \
       frameworks/native \
       frameworks/opt/telephony \
       frameworks/rs \
       frameworks/wilhelm \
       libcore \
       packages/apps/DeskClock \
       packages/apps/Mms \
       packages/apps/Settings \
       system/security \
       vendor/cm"

for x in $REPOS
do
    cd $x
    (git checkout myjb-next || git checkout -b myjb-next) > /dev/null 2>&1
    git pull cm cm-10.1 2>err.txt
    if [ $? != 0 ]; then
        echo -e "\n### MERGE of \"$x\" FAILED ###\n"
        cat err.txt
        break
    fi
    echo -e "\n### MERGE of \"$x\" SUCCESSFUL ###\n"
    git push origin myjb-next 2>err.txt
    if [ $? != 0 ]; then
        echo -e "\n### PUSHING of \"$x\" TO GITHUB FAILED ###\n"
        cat err.txt
        break
    fi
    echo -e "\n### PUSHING of \"$x\" TO GITHUB SUCCESSFUL ###\n"
    rm -f err.txt
    cd $HOME
done

rm -f err.txt

