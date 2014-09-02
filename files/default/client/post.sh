#! /bin/sh

/bin/run-parts --exit-on-error --report --umask=002 -- /etc/burp/post.d
