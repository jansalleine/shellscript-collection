#!/bin/sh

jaillist=`fail2ban-client status | grep list | cut -f 2 | cut -d ","  --output-delimiter=" " -f 1-`

for jail in $jaillist
do
    fail2ban-client status "$jail"
done
