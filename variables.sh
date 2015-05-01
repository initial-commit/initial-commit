source application.sh
if [[ ! -f sensitive.sh ]]; then
    echo "Please make a copy of sensitive.sh.dist and fill in the values"
    exit 1
fi
source sensitive.sh

BOXROOT_LOGICAL_NAME=root

BOXROOT_ROOT_NAME=root
BOXROOT_ROOT_USERNAME=${BOXROOT_ROOT_NAME}+${BOXROOT_LOGICAL_NAME}
BOXROOT_ROOT_EMAIL=${BOXROOT_ROOT_USERNAME}@${APPDOMAIN}
