#!/bin/sh

# This script is just part of a preliminary mechanism to
# launch any of the MB-System programs.

program=$1

if [[ "${program}" == "" ]]; then
	echo -e "runmbp: No program specified"
	exit 1
fi

shift

export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

${program} "$@"
