# you only need to set the primary IP
BOXROOT_IP=

APPDOMAIN=initial-commit.org
BOXROOT_HOSTNAME=initial-commit

BOXROOT_LOGICAL_NAME=root

BOXROOT_ROOT_NAME=root
BOXROOT_ROOT_USERNAME=${BOXROOT_ROOT_NAME}+${BOXROOT_LOGICAL_NAME}
BOXROOT_ROOT_EMAIL=${BOXROOT_ROOT_USERNAME}@${APPDOMAIN}

BOXROOT_ADMIN_USERNAME=flav
BOXROOT_ADMIN_NAME="Flavius Aspra"
BOXROOT_ADMIN_EMAIL=${BOXROOT_ADMIN_USERNAME}+${BOXROOT_LOGICAL_NAME}@${APPDOMAIN}
