#! /bin/sh

/bin/run-parts --exit-on-error --lsbsysinit --report --umask=002 -- /etc/burp/pre.d
