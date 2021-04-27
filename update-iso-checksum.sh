#!/bin/bash
# this will update the alpine.json file with the current image checksum.
set -eux
iso_url=$(jq -r '.variables.iso_url' alpine.json)
iso_checksum=$(curl -o- --silent --show-error $iso_url.sha256 | awk '{print $1}')
case $(uname -s) in Darwin) alias sed=gsed ;; esac
sed -i -E "s,(\"iso_checksum\": \")([a-f0-9]+|)(\"),\\1$iso_checksum\\3,g" alpine.json
echo 'iso_checksum updated successfully'
