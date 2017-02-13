#!/bin/bash

set -e

./return_code/make
./hello_world/make
./dub/make
./all_dmd_versions/make

rm -rf dub-examples && git clone https://github.com/dlang/dub.git dub-examples
(cd dub-examples && docker run -ti -v $(pwd):/src dlanguage/dmd "apt-get update && apt-get install -y libcurl3-dev && dub build")
