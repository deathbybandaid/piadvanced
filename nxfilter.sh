## https://qrys.ch/running-nxfilter-on-a-headless-raspberry-pi/


## the stuff below is for dnsmasq

# From here entries from Jeroen
local=/noads.local/
domain=noads.local
address=/raspberry.noads.local/192.168.1.2
address=/wpad.noads.local/192.168.1.2
address=/wpad/192.168.1.2
dhcp-authoritative
#dhcp-range=set:red,192.168.1.100,192.168.1.199,255.255.255.0,72h
dhcp-range=set:red,192.168.1.100,192.168.1.199,255.255.255.0,365d
dhcp-option=tag:red,6,192.168.1.4,192.168.1.2,208.67.222.222,8.8.8.8
dhcp-option=tag:red,option:router,192.168.1.1
# dhcp-option=tag:red,option:ntp-server,192.168.1.2
dhcp-option=19,0
dhcp-option=42,0.0.0.0
dhcp-option=44,192.168.1.2
dhcp-option=45,0.0.0.0
dhcp-option=46,8
all-servers
txt-record=wpad,"service:wpad:!http://192.168.1.2:80/wpad.dat?"
srv-host=wpad.tcp.wpad,wpad.wpad,80
srv-host=_wpad._tcp.192.168.1.2,wpad.192.168.1.2,80
dhcp-option=252,"http://192.168.1.2/wpad.dat?"
