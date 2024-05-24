#!/bin/env python2
## This file is managed by Puppet; changes may be overwritten.

# Reads binary data from stdin and attempts to interpret it as the
# result of a combination raw ADS reads of various configuration
# settings PTP device. The byte order is little-endian.

import datetime
from ipaddress import ip_address
from struct import unpack
import sys

def strIpType(ipType):
    s = "Unknown IP address type"
    if ipType == 0:
        s = "DHCP"
    elif ipType == 1:
        s = "FIXED"
    return s + " (" + str(ipType) + ")"

roles = dict()
roles[16] = "PTPv1 Slave Only"
roles[17] = "PTPv1 Best Master"
roles[18] = "PTPv1 Grandmaster"
roles[32] = "PTPv2 Slave Only"
roles[33] = "PTPv2 Best Master"
roles[34] = "PTPv2 Grandmaster"

def strRole(ptpRole):
    s = "Unknown PTP protocol setting"
    if ptpRole in roles:
        s = roles[ptpRole]
    return s + " (" + str(ptpRole) + ")"

def strTransport(trans):
    s = "Unknown transport"
    if trans == 0:
        s = "Layer 2, PTP over Ethernet"
    elif trans == 1:
        s = "Layer 3, PTP over UDP"
    return s + " (" + str(trans) + ")"

def strSync(sync):
    return str(sync)

def strInterval(intval):
    if intval == 255:
        s = "0.5"
    else:
        s = str(1 << intval)
    return s + " (" + str(intval) + ")"

def strMech(mech):
    s = "Unknown mechanism"
    if mech == 0:
        s = "DISABLED"
    elif mech == 1:
        s = "End To End"
    elif mech == 2:
        s = "Point To Point"
    return s + " (" + str(mech) + ")"

def strHex(by):
    return " ".join("{:02x}".format(ord(b)) for b in by)

rawcoe = sys.stdin.read()
coe = list(unpack("<H3IH9H6s", rawcoe))

print "Local date and time:        ", datetime.datetime.now()
print "MAC address:                ", strHex(       coe[14]      )
print "IP address type:            ", strIpType(    coe[ 0]      )
print "IP address:                 ", ip_address(   coe[ 1]      )
print "Net mask:                   ", ip_address(   coe[ 2]      )
print "Gateway IP address:         ", ip_address(   coe[ 3]      )
print "PTP protocol and role:      ", strRole(      coe[ 4]      )
print "Transport layer:            ", strTransport( coe[ 5]      )
print "Domain number:              ",               coe[ 6]
print "Sync interval (sec):        ", strInterval(  coe[ 7]      )
print "Delay interval (sec):       ", strInterval(  coe[ 8]      )
print "Delay mechanism:            ", strMech(      coe[ 9]      )
print "Announce interval (sec):    ", strInterval(  coe[10]      )
print "Announce TO (intervals):    ",               coe[11]
print "Priority 1:                 ",               coe[12]
print "Priority 2:                 ",               coe[13]

