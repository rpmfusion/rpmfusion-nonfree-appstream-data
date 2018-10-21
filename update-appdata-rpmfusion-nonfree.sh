#!/bin/bash
RELEASE=""
URL=""

main ()
{
    mkdir rpmfusion-nonfree/ -pv
    cd rpmfusion-nonfree || exit -1
#
    if [ "$RELEASE" =  "30" ]; then
        URL="rsync://rsync.mirrorservice.org/download1.rpmfusion.org/nonfree/fedora/development/rawhide/Everything/x86_64/os/*"
    elif [ "$RELEASE" =  "29" ]; then
        URL="rsync://rsync.mirrorservice.org/download1.rpmfusion.org/nonfree/fedora/development/29/Everything/x86_64/os/*"
    elif [ "$RELEASE" = "28" ]; then
        URL="rsync://rsync.mirrorservice.org/download1.rpmfusion.org/nonfree/fedora/releases/28/Everything/x86_64/os/*"
    elif [ "$RELEASE" = "27" ]; then
        URL="rsync://rsync.mirrorservice.org/download1.rpmfusion.org/nonfree/fedora/releases/27/Everything/x86_64/os/*"

    fi

    rsync -avPh "$URL" .
    rm -rf repo*
#
    appstream-builder --verbose --max-threads=6 --log-dir=./logs/ \
    --packages-dir=./Packages/ --temp-dir=./tmp/ --output-dir=./appstream-data/ \
    --basename="rpmfusion-nonfree-$RELEASE" --origin="rpmfusion-nonfree-$RELEASE" \
    --enable-hidpi

    echo "Generated files are present in the appstream-data directory"
}

usage ()
{
    echo "$0 -r <release>"
    echo "- update appdata for rpmfusion nonfree repository"
    echo "options:"
    echo "-r <release> one of 27, 28, 29, and 30"
}


if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

# parse options
while getopts "r:h" OPTION
do
    case $OPTION in
        r)
            RELEASE=$OPTARG
            main
            ;;
        h)
            usage
            exit 1
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done
