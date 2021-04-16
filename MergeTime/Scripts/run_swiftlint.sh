#!/bin/sh

#  run_swiftlint.sh
#  MergeTime
#
#  Created by Vlad Shkodich on 16.04.2021.
#  

if [ "${PODS_ROOT+x}" ] && [ -x "${PODS_ROOT}/SwiftLint/swiftlint" ]; then
    ${PODS_ROOT}/SwiftLint/swiftlint --config swiftlint.yml --quiet
elif which swiftlint >/dev/null; then
    swiftlint --config swiftlint.yml --quiet
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
