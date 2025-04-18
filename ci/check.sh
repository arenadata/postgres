#!/bin/bash

set -eu

# unsets limit for coredumps size
ulimit -c unlimited -S
# sets a coredump file pattern
mkdir -p /tmp/cores-$CI_COMMIT_SHA-$TIMESTAMP
sh -c "echo \"/tmp/cores-$CI_COMMIT_SHA-$TIMESTAMP/%t_%p_%s.core\" > /proc/sys/kernel/core_pattern"

make check-world -j4
