#!/bin/bash

set -eu

# unsets limit for coredumps size
ulimit -c unlimited -S

# initdb has to be run as non-root user
useradd -m postgres
su - postgres -c "cd $(pwd) && PATH=\"$PATH\" make check-world -j4"