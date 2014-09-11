#! /bin/sh

/bin/run-parts --report --lsbsysinit --umask=002 -- /etc/burp/post.d
