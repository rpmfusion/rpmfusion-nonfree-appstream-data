#!/bin/bash
RELEASE=""
URL=""
#URL1=""

main ()
{
    mkdir rpmfusion-nonfree/ -pv
    cd rpmfusion-nonfree || exit -1
#
    if [ "$RELEASE" =  "36" ]; then
        URL="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/development/rawhide/Everything/x86_64/os/*"
    elif [ "$RELEASE" = "35" ]; then
        URL="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/releases/35/Everything/x86_64/os/*"
    elif [ "$RELEASE" =  "34" ]; then
        URL="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/releases/34/Everything/x86_64/os/*"
        #URL1="rsync://download1.rpmfusion.org/rpmfusion/nonfree/fedora/updates/33/x86_64/*"
    fi

    rsync -avPh --delete "$URL" .
#    rsync -avPh --delete --exclude debug "$URL1" ./Packages/

    rm -rf repo*
#    rm -rf Packages/repo*
#    createrepo -d Packages/
#    repomanage -o --space  ./Packages/ | xargs rm
#    rm -rf Packages/repo*
#
    appstream-builder --verbose  --include-failed --max-threads=6 --log-dir=./logs/ \
    --packages-dir=./Packages/ --temp-dir=./tmp/ --output-dir=./appstream-data/ \
    --basename="rpmfusion-nonfree-$RELEASE" --origin="rpmfusion-nonfree-$RELEASE" \
    --enable-hidpi --veto-ignore=missing-parents

    echo "Generated files are present in the appstream-data directory"
}

usage ()
{
    echo "$0 -r <release>"
    echo "- update appdata for rpmfusion nonfree repository"
    echo "options:"
    echo "-r <release> one of 34, 35 and 36"
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
