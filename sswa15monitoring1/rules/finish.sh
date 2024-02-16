#!/bin/bash

httpbin_retcode="$(curl localhost:8000/probe)"

jq --null-input \
--arg httpbin_retcode "$httpbin_retcode" \
'{"httpbin_retcode": $httpbin_retcode
}'| jq -n '.results |= [inputs]'
