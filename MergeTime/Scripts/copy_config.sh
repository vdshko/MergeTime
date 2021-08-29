#!/bin/sh

#  copy_config.sh
#  MergeTime
#
#  Created by Vlad Shkodich on 17.04.2021.
#

if [ -f "${SRCROOT}/Config/plist/${CONFIG_FILE}" ]; then
    cp "${SRCROOT}/Config/plist/${CONFIG_FILE}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/Config.plist"
fi
