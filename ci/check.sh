#!/bin/bash

set -eu

# unsets limit for coredumps size
ulimit -c unlimited -S
# sets a coredump file pattern
mkdir -p /tmp/cores-$CI_COMMIT_SHA-$CI_PIPELINE_CREATED_AT
sh -c "echo \"/tmp/cores-$CI_COMMIT_SHA-$CI_PIPELINE_CREATED_AT/%t_%p_%s.core\" > /proc/sys/kernel/core_pattern"

make check-world -j4
