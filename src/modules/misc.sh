#!/bin/bash

# Checks that all dependencies are available
function b.misc.has_dependencies? () {
    for dependency in $1; do
        hash "$dependency" 2>&-
        if [ $? == 1 ]; then
            b.raise RequiredAppNotInstalled  "This script depends on '$dependency', but it is not executable. Check your \$PATH definition or install it before running."
            return 1;
        fi
    done;
}
