#!/bin/bash

set -eu

# unsets limit for coredumps size
ulimit -c unlimited -S

make check-world -j4
