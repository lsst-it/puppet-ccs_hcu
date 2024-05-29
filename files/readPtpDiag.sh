#!/bin/bash
## This file is managed by Puppet; changes may be overwritten.

homeDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# This script uses adstool to read the CoE data for "PTP Diag" from
# the EL6688 PTP device on shutter unit 2, then feeds the binary data to
# the decodePTPDiag.py script for pretty-printing.
#
# See the Confluence page https://confluence.slac.stanford.edu/x/uXYtFw

# shellcheck source=./files/ptpCoeSetup.sh
source "${homeDir}"/ptpCoeSetup.sh

# Can we contact the Beckhoff controller? Try asking for its ADS address.
if ! "${homeDir}"/adstool "${shutterControllerIp}" netid >/dev/null; then
    echo "Could not contact the Beckhoff controller."
    exit 1
 fi

# ADS addressing for the PTP module on EtherCAT.
netId="${ethercatNetId}"
port="${ptpAdsPort}"

# The CoE address for the PTP diagnostic data. We use the special subindex
# that means read all subindexes.
coeIndex=0xfa80
coeSubindex=0x0101

# Obtain the binary CoE data converted to a hex string.
byteCount=54
ptpDiagData=$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})

# The latest external (PTP) timestamp is in the External Sync PDO group.
coeIndex=0x10f4
coeSubindex=0x12
byteCount=8
ptpStamp=$(readRawCoe ${netId} ${port} ${coeIndex} ${coeSubindex} ${byteCount})

# Concatenate the pieces of data, convert back to binary and decode.
echo "${ptpDiagData}${ptpStamp}" | xxd -p -r | "${homeDir}"/decodePtpDiag.py
