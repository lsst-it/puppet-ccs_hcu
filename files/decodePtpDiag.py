#!/usr/bin/python3
## This file is managed by Puppet; changes may be overwritten.

# Reads binary data from stdin and attempts to interpret it as the
# result of a raw ADS read of the CoE group "PTP Diag" from an EL6688
# PTP device followed by the external (PTP) timestamp maintained by
# the same device. The byte order is little-endian.

from datetime import datetime, timedelta
from struct import unpack
import sys


def main():
    rawcoe = sys.stdin.buffer.read()
    # The length of the binary data must exactly match that implied by the unpacking format.
    # An exception will be raised if this isn't the case.
    coe = list(unpack("<HH8s10s8siI8HQ", rawcoe))
    print("HCU date and time:          ", datetime.now())
    print("PTP version:                ", strVersion(           coe[ 0] ))
    print("PTP state:                  ", strState(             coe[ 1] ))
    print("Clock ID (hex):             ", binHex(               coe[ 2] ))
    print("Master clock ID (hex):      ", binHex(               coe[ 3] ))
    print("Grandmaster clock ID (hex): ", binHex(               coe[ 4] ))
    print("Offset from master (ns):    ", "{:,}".format(        coe[ 5] ))
    print("Mean path delay (ns):       ", "{:,}".format(        coe[ 6] ))
    print("Steps removed:              ",                       coe[ 7])
    print("Sync msg sequence no.:      ",                       coe[ 8])
    print("Time scale:                 ", strScale(             coe[ 9] ))
    print("Offset from UTC (sec):      ",                       coe[10])
    print("UTC offset valid?           ", bool(                 coe[11] ))
    print("Leap61?                     ", bool(                 coe[12] ))
    print("Leap59?                     ", bool(                 coe[13] ))
    print("Epoch no.:                  ",                       coe[14])
    print("External (PTP) time:        ", strTime(              coe[15], coe[10], bool(coe[11])))


def strVersion(verNum):
    s = "Unknown PTP version"
    if verNum == 0x10:
        s = "PTPv1"
    elif verNum == 0x20:
        s = "PTPv2"
    return s + " (" + str(verNum) + ")"


states = dict()
states[0] = "NO OPERATION"
states[1] = "INITIALIZING"
states[2] = "FAULTY"
states[3] = "DISABLED"
states[4] = "LISTENING"
states[5] = "PRE_MASTER"
states[6] = "MASTER"
states[7] = "PASSIVE"
states[8] = "UNCALIBRATED"
states[9] = "SLAVE"

def strState(stateNum):
    s = "Unknown state"
    if stateNum in states:
        s = states[stateNum]
    return s + " (" + str(stateNum) + ")"


def binHex(by):
    return " ".join("{:02x}".format(b) for b in by)


def strScale(scaleNum):
    s = "Unknown time scale"
    if scaleNum == 0:
        s = "UTC"
    elif scaleNum == 1:
        s = "PTP/TAI"
    elif scaleNum == 2:
        s = "N/A"
    return s + " (" + str(scaleNum) + ")"


beckhoffEpoch = datetime(2000, 1, 1, 0, 0, 0)

def strTime(time64, utcOffset, offsetIsValid):
    # time64: A Beckhoff timestamp in the T_TIME64 format of nanoseconds since the Beckhoff epoch.
    # utcOffset: The count of leap seconds to subtract to get UTC.
    # offsetIsValid: Is the PTP module is receiving UTC offset info from its master clock?
    # Convert to seconds.
    secs = time64 / 1e9
    # Subtract leap second count if possible.
    if offsetIsValid:
        secs -= utcOffset
        zone = "UTC"
    else:
        zone = "DTAI (UTC offset is invalid)"
    # Convert to human-readable time.
    result = beckhoffEpoch + timedelta(seconds=secs)
    # The datetime library also attempts to compensate for leap seconds
    # so we add them again. The result will be correct only if the PTP module
    # and the datetime library agree on the number of leap seconds.
    if offsetIsValid:
        result += timedelta(utcOffset)
    return result.strftime(f"%a, %d %b %Y %H:%M:%S.%f {zone}")


if __name__ == "__main__":
    main()
