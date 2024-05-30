## This file is managed by Puppet; changes may be overwritten.
# shellcheck shell=bash
# This file is meant to be sourced by CoE-reading scripts such as readPTPDiag.sh

# The AMS netId of the EtherCAT master. This follows the TwinCAT project
# so it's the same for both shutter units provided they're running
# the same firmware.
export ethercatNetId="10.0.1.28.2.1"

# The ADS port for the EL6688 PTP device (decimal).
export ptpAdsPort="1007"

# The ADS Group Index for CoE access.
adsCoeGroup=0xf302

# We don't run a Beckhoff address server, so we need to give the IP
# address of the controller in order to make contact. This is the standard
# local address we set up in the HCUs.
export shutterControllerIp="192.168.10.40"

# Use adstool to get the binary CoE data and return the equivalent hex text as produced by xxd.
# Arguments are netId port coeIndex coeSubindex byteCount
# netId is the dotted AMS address of the EtherCAT controller.
# port is ADS port number, which in this case is the EtherCAT address of the PTP device. Decimal integer.
# coeIndex is the CoE index number. May be decimal or hex according to the usual prefix rules, e.g., 0x1234.
# coeSubindex is the CoE subindex. Same format as coeIndex.
# byteCount is the number of bytes to read.
function readRawCoe() {
    declare netId="$1"
    declare port="$2"
    declare -i coeIndex="$3"
    declare -i coeSubindex="$4"
    declare byteCount="$5"
    declare -i adsOffset=$(((coeIndex<<16)+coeSubindex))
# shellcheck disable=SC2154
    "${homeDir}"/adstool "${netId}":"${port}" --gw="${shutterControllerIp}" raw --read="${byteCount}" "${adsCoeGroup}" "${adsOffset}" 2>/dev/null | xxd -p
}
