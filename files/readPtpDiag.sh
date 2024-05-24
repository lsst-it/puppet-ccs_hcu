#!/bin/bash
homeDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# This script uses adstool to read the CoE data for "PTP Diag" from
# the EL6688 PTP device on shutter unit 2, then feeds the binary data to
# the decodePTPDiag.py script for pretty-printing.
#
# See the Confluence page https://confluence.slac.stanford.edu/x/uXYtFw

source ${homeDir}/ptpCoeSetup.sh

# The CoE address for the PTP diagnostic data. We use the special subindex
# that means read all subindexes.
coeIndex=0xfa80
coeSubindex=0x0101

# The total number of data bytes to read.
byteCount=54

# Index for the shutter unit. Right now it's hard-coded for unit 2.
iunit=1

# Obtain the raw CoE data then decode it.
echo $(readRawCoe ${ethercatNetId[iunit]} ${ptpAdsPort[iunit]} ${coeIndex} ${coeSubindex} ${byteCount})\
       | xxd -p -r | python -u ${homeDir}/decodePtpDiag.py
