#!/bin/bash

cd $(dirname $0)"/../"
HOME=$(pwd)

REPOS="bionic \
       build \
       external/oprofile \
       external/v8 \
       frameworks/base \
       frameworks/rs \
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
    cd $HOME
done

rm -f err.txt

