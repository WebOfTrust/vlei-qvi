#!/bin/bash

##################################################################
##                                                              ##
##          Script for executing random kli commands            ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Enter the SAID of the credential to present: " -r said
read -p "Enter the alias of the recipient of the presentation: " -r recipient

# Run the sub command
kli vc present --name "${QAR_NAME}" --alias "${QAR_AID_ALIAS}" --passcode "${passcode}" --said "${said}" --recipient "${recipient}" --include