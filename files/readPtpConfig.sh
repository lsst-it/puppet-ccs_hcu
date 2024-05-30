#!/bin/bash
## This file is managed by Puppet; changes may be overwritten.

# This script uses adstool to read various configuration parameters
# from the CoE interface of the EL6688 PTP device.

homeDir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# shellcheck source=./files/ptpCoeSetup.sh
source "${homeDir}"/ptpCoeSetup.sh

# Can we contact the Beckhoff controller? Ask it for its AMS address.
if ! "${homeDir}"/adstool "${shutterControllerIp}" netid >/dev/null; then
    echo "Could not contact the Beckhoff controller."
    exit 1
 fi

# This means read all subindexes.
coeSubindex=0x0101

# ADS addressing for the PTP module on EtherCAT.
netId="${ethercatNetId}"
port="${ptpAdsPort}"

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
coeSubindex=0x0001
byteCount=6
rawcoe="${rawcoe}$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})"

# Convert to binary and decode.
echo "${rawcoe}" | xxd -p -r | "${homeDir}"/decodePtpConfig.py
