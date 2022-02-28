#!/bin/bash
RAWHIDE="37"
RELEASE=""
URL_DEV=""
URL_RELEASE=""
TEMPDIR="rpmfusion-nonfree"

main ()
{
    rm -rf rpmfusion-nonfree
    mkdir rpmfusion-nonfree/ -pv
    cd rpmfusion-nonfree || exit -1

    if [ $RELEASE -le $RAWHIDE ] && [ $RELEASE -ge $((RAWHIDE - 3)) ]; then
        if [ "$RELEASE" = "$RAWHIDE" ]; then
            RELEASE="rawhide"
        fi

        URL_DEV="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/development/${RELEASE}/Everything/x86_64/os/*"
        URL_RELEASE="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/releases/${RELEASE}/Everything/x86_64/os/*"

        echo "Regenerating for $RELEASE"
        rsync -avPh "$URL_RELEASE" . || rsync -avPh "$URL_DEV" .
    else
        echo "Please check if ${RELEASE} is currently supported. Rawhide is at ${RAWHIDE}."
        exit -1
    fi

    if ! command -v appstream-builder > /dev/null
    then
        echo "appstream-builder not installed. Installing now."
        sudo dnf install /usr/bin/appstream-builder -y
    fi

    appstream-builder --verbose --include-failed --max-threads=6 --log-dir=./logs/ \
    --packages-dir=./Packages/ --temp-dir=./tmp/ --output-dir=./appstream-data/ \
    --basename="rpmfusion-nonfree-$RELEASE" --origin="rpmfusion-nonfree-$RELEASE" \
    --enable-hidpi --veto-ignore=missing-parents

    echo "Generated files are present in the appstream-data directory"
    echo "To import new sources, run:"
    echo "rfpkg new-sources ${TEMPDIR}/appstream-data/rpmfusion-nonfree-${RELEASE}-icons.tar.gz ${TEMPDIR}/appstream-data/rpmfusion-nonfree-${RELEASE}.xml.gz"

}

usage ()
{
    echo "$0 -r <release>"
    echo "- update appdata for rpmfusion nonfree repository"
    echo "options:"
    echo "-r <release> one of [$RAWHIDE, $((RAWHIDE -3))]"
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
