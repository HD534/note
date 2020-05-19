/users/asnpifw/cdctest/test-sqlfile/sit-run.sh /trf/sprr/hpsyb11/run

: set number 
show number

:0,50
s/\/trf\/sprr\/hpsyb11\/run/\/users\/asnpifw\/cdctest\/test-sqlfile\/sit-run.sh/g


s/users\/asnpifw\/cdctest\/test-sqlfile\/sit-run.sh/#!\/users\/asnpifw\/cdctest\/test-sqlfile\/sit-run.sh/g


^ ->  (empty)
` %s/\^/ `