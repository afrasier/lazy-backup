#!/bin/bash

# How many backups shnould we keep?
NUM_BACKUPS=10

# Basic backup script
LABEL="whatever"
DATA_DIRECTORY="wherever NO SLASH"
BACKUP_DIRECTORY="wherever NO SLASH"

TIMESTAMP=`date "+%y-%m-%dT%H-%M-%S"`

cd $DATA_DIRECTORY

echo "Creating backup $TIMESTAMP-$LABEL.tar..."

tar -cvf $BACKUP_DIRECTORY/$TIMESTAMP-$LABEL.tar .

echo 'Made.'

cd $BACKUP_DIRECTORY

CURRENT_BACKUPS=`ls | wc -l`

echo "Currently have $CURRENT_BACKUPS backups"

if [ "$CURRENT_BACKUPS" -gt "$NUM_BACKUPS" ]; then
    echo "Exceeded max backups, deleting oldest"
    ls -t | sed -e '1,'"$NUM_BACKUPS"'d' | xargs -d '\n' rm
fi

echo "DONE"
