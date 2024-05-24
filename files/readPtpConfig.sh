#!/bin/bash

# This script uses adstool to read various configuration parameters
# from the CoE interface of the EL6688 PTP device.

homeDir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source ${homeDir}/ptpCoeSetup.sh

# This means read all subindexes.
coeSubindex=0x0101

# Index for the shutter unit. Right now it's hard-coded for unit 2.
iunit=1
netId="${ethercatNetId[iunit]}"
port="${ptpAdsPort[iunit]}"

rawcoe=""

# Ethernet settings.
coeIndex=0xf8e0
byteCount=14
rawcoe="${rawcoe}$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})"

# PTP common settings.
coeIndex=0xf880
byteCount=2
rawcoe="${rawcoe}$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})"

# PTPv2 settings.
coeIndex=0xf882
byteCount=18
rawcoe="${rawcoe}$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})"

# MAC address
coeIndex=0xf8f0
coeSubIndex=0x0001
byteCount=6
rawcoe="${rawcoe}$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})"

# Convert to binary and decode.
echo "${rawcoe}" | xxd -p -r | python2 -u ${homeDir}/decodePtpConfig.py
