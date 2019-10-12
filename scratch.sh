#!/usr/bin/env bash
set -e

function backup_restrore()
{
    if [ $# -ne 2 ];
    then
        echo "parameter should be source and destination"
        echo "here get $# parameters: $*"
        return 1
    fi
    source=$1
    destination=$2
    if [ -e "${destination}" ];
    then
        cp "${destination}" "${source}"
    else
        cp "${source}" "${destination}"
    fi
    echo "backup complete"
    return 0
}

function