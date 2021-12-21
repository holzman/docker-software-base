#!/bin/bash

# Bash script that checks if the given RPM version is older than the EVR
# Exits 0 if RPM is older than the EVR, 1 otherwise

USAGE="Usage: pkg-cmp-lt.sh <RPM> <EVR>"

RPM=$1
EVR=$2

if [[ $# -ne 2 ]]; then
    echo "Expected 2 args, got $#"
    echo "$USAGE"
    exit
fi

RPM_EVR=$(rpm -q --queryformat '%{EPOCH}:%{VERSION}-%{RELEASE}\n' $RPM) # get EVR of the RPM
RPM_EVR=${RPM_VER/(none)/0} # no epoch will print (none) for the epoch field so we change it to 0

rpmdev-vercmp RPM_EVR EVR # check if RPM is older than the EVR
if [[ $? == 12 ]]; then
    exit 0
else
    exit 1
fi
