#!/bin/bash

##################################################################
##                                                              ##
##        Script for creating local QAR AID                     ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password and salt
passcode=$(get_passcode $1)
salt=$(get_salt $1)

# Test to see if this script has already been run:
OUTPUT=$(kli list --name "${QAR_NAME}" --passcode "${passcode}")
ret=$?
if [ $ret -eq 0 ]; then
   echo "Local AID for ${QAR_NAME} already exists, exiting:"
   printf "\t%s\n" "${OUTPUT}"
   exit 69
fi

# Create the local database environment (directories, datastore, keystore)
kli init --name "${QAR_NAME}" --salt "${salt}" --passcode "${passcode}" --config-dir ${QAR_SCRIPT_DIR} --config-file qar-config.json

# Create your local AID for use as a participant in the External AID
kli incept --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}" --file ${QAR_SCRIPT_DIR}/qar-local-incept.json

# Here's your AID:
kli status --name "${QAR_NAME}" --alias "${QAR_ALIAS}" --passcode "${passcode}"