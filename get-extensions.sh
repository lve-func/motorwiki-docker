#!/bin/bash
exts="$@"

for ext in $exts
do
    response=$(curl -s "https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&edbexts=$ext&formatversion=2&format=json")
    link=$(jq -r ".query.extdistbranches.extensions.$ext.REL1_37" <<< $response)

    if [ "$link" = "null" ]
    then
        link=$(jq -r ".query.extdistbranches.extensions.$ext.master" <<< $response)
    fi
    
    echo "Downloading from $link"

    curl -s "$link" -o "$ext".tar.gz
    tar -xzf "$ext".tar.gz
    rm $ext.tar.gz
done
