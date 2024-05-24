#!/usr/bin/python3 -u
## This file is managed by Puppet; changes may be overwritten.

# Reads binary data from stdin and attempts to interpret it as the
# result of a raw ADS read of the CoE group "PTP Diag" from an EL6688
# PTP device. The byte order is little-endian.

import datetime
from struct import unpack
import sys


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

def strHex(by):
    return " ".join("{:02x}".format(ord(b)) for b in by)

def strScale(scaleNum):
    s = "Unknown time scale"
    if scaleNum == 0:
        s = "UTC"
    elif scaleNum == 1:
        s = "PTP/TAI"
    elif scaleNum == 2:
        s = "N/A"
    return s + " (" + str(scaleNum) + ")"

rawcoe = sys.stdin.buffer.read()
coe = list(unpack("<HH8s10s8siI8H", rawcoe))
print("Local date and time:        ", datetime.datetime.now())
print("PTP version:                ", strVersion(           coe[ 0] ))
print("PTP state:                  ", strState(             coe[ 1] ))
print("Clock ID (hex):             ", strHex(               coe[ 2] ))
print("Parent clock ID (hex):      ", strHex(               coe[ 3] ))
print("Grandmaster clock ID (hex): ", strHex(               coe[ 4] ))
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
