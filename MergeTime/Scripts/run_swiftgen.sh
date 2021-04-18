#!/bin/sh

#  run_swiftgen.sh
#  MergeTime
#
#  Created by Vlad Shkodich on 18.04.2021.
#  

if [ "${PODS_ROOT+x}" ] && [ -x "${PODS_ROOT}/SwiftGen/bin/swiftgen" ]; then
    ${PODS_ROOT}/SwiftGen/bin/swiftgen
elif which swiftgen >/dev/null; then
    swiftgen
else
    echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
fi
