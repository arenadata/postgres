#!/bin/bash

set -eu

status=0

# show diff if it exists
for f in ` find . -name regression.diffs ` ; do
	echo "========= Contents of $f"
	cat $f
	status=1
done

# check core dumps if any
# due to CI limitations only one, latest core dump, can be preserved in a each directory
# e.g. we cannot change core_pattern
cores=$(find . -name 'core' 2>/dev/null)

if [ -n "$cores" ]; then
	for corefile in $cores ; do
		if [[ $corefile != *_3.core ]]; then
			binary=$(gdb -quiet -core $corefile -batch -ex 'info auxv' | grep AT_EXECFN | perl -pe "s/^.*\"(.*)\"\$/\$1/g")
			echo dumping $corefile for $binary
			gdb --batch --quiet -ex "thread apply all bt full" -ex "quit" $binary $corefile
			status=1
		fi
	done
fi

rm -rf /tmp/cores-$CI_COMMIT_SHA-$CI_PIPELINE_CREATED_AT

exit $status
