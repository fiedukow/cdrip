#/bin/bash -e

# Fill those in for automatic upload to funkwhale.
USER_TOKEN=
LIBRARY_UID=

# See install_debian.sh to install abcde and its soft deps used below.

# -Q query all data sources in the default order
# -x eject cd after it's ripped
# -o output 160kbps MP3 file
# -G download cover jpeg
# -N non interactive - answer to all questions with defaults
# -V verbose
# -p pad track numbers with 0
# -j number of encoder process that can run at once
abcde -Q musicbrainz,cddb,cdtext -x -o'mp3:-b 160' -G -N -V -p -j 16 | tee rip.log

OUTPUT_DIR=`cat rip.log | grep "copying cover" | awk 'NF>1{print $NF}'`

echo "Uploading..."
funkwhale -t $USER_TOKEN uploads create $LIBRARY_UID $OUTPUT_DIR/*.mp3


