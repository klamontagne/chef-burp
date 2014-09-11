#! /bin/sh

/bin/run-parts --exit-on-error --report --lsbsysinit --umask=002 -- /etc/burp/post.d
