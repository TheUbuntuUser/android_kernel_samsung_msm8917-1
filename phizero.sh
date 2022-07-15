#!/bin/bash

# Settings
USER=TheUbuntuUser
HOST=geckyn
CORES=$(echo $(nproc --all) Cores Detected)

# Color definition
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

# Get date and time
DATE=$(date +"%m-%d-%y")
BUILD_START=$(date +"%s")

# Set Defconfigs
DEF2=j2y18lte_defconfig
DEF4=j4primelte_defconfig
DEF6=j6primelte_defconfig

ENVSET() {
    export ARCH=arm64 && export SUBARCH=arm64
    export CROSS_COMPILE=$(pwd)/gcc/bin/aarch64-linux-gnu-
    export PATH=$(pwd)/gcc/bin:$PATH
    export KBUILD_BUILD_USER=$USER
    export KBUILD_BUILD_HOST=$HOST
}

J250XMAKE() {
    make O=out CROSS_COMPILE=aarch64-linux-gnu- $DEF2
}

J4PLUSMAKE() {
    make O=out CROSS_COMPILE=arm-linux-androideabi- $DEF4
}

J6PLUSMAKE() {
    make O=out CROSS_COMPILE=arm-linux-androideabi- $DEF6
}

COMPILE() {
    make O=out CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc --all)
}

TIME() {
    # Find how much build has been long
    BUILD_END=$(date +"%s")
    DIFF=$(($BUILD_END - $BUILD_START))
    echo -e "$green Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds $reset"
}

BUILDINFO() {
    echo -e "******************************************************"
    echo "*             Phizero Build Script"
    echo "*                  Developer:geckyn and TheUbuntuUser"
    echo "*"
    echo "*          Compiling kernel using Linaro 6.5(201812)"
    echo "*"
    echo "* Some information about parameters set:"
    echo -e "*  > Architecture: $ARCH"
    echo    "*  > Jobs: $CORES"
    echo    "*  > Build user: $KBUILD_BUILD_USER"
    echo    "*  > Build machine: $KBUILD_BUILD_HOST"
    echo    "*  > Build started on: $BUILD_START"
    echo    "*  > ARM64 Toolchain exported"
    echo -e "******************************************************"
    echo " "
}

PS3='Please Select a Device: '
options=("Galaxy J4 Plus" "Galaxy J6 Plus" "SM-J250X" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Galaxy J4 Plus")
            echo ""
            echo "$cyan Samsung Galaxy J4+ Selected $reset"
            echo ""
	    ENVSET
	    echo ""
            J4PLUSMAKE
            echo ""
            BUILDINFO
            echo ""
            COMPILE
            echo ""
            TIME
            echo ""
            break
            ;;
        "Galaxy J6 Plus")
            echo ""
            echo "$cyan Samsung Galaxy J6+ Selected $reset"
            echo ""
	    ENVSET
	    echo ""
            J6PLUSMAKE
            echo ""
            BUILDINFO
            echo ""
            COMPILE
            echo ""
            TIME
            echo ""
            break
            ;;
        "SM-J250X")
            echo ""
            echo "$cyan SM-J250X Selected $reset"
            echo ""
	    ENVSET
	    echo ""
            J250XMAKE
            echo ""
            BUILDINFO
            echo ""
            COMPILE
            echo ""
            TIME
            echo ""
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
