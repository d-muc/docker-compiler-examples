# Docker D Compiler Examples

[![Build Status](https://travis-ci.org/d-muc/docker-compiler-examples.svg)](https://travis-ci.org/d-muc/docker-compiler-examples)

Examples for Running D Compilers as Docker Containers

- return code - to show the simplest possible d program without any library
- hello world - the simplest possible d program using phobos
- all dmd versions - to compile same source with all available dmd versions
- dub - to show the simplest possible dub project without any dependency
- building dub itself - complex dub project

## Compile Script

Invoke this script to compile with a dockerized D compiler.

Options:
 - FORCE_PULL - pulls the latest available docker image
 - USE_LOCAL_USER - uses your local user within the docker container instead of root
 - verbose - print used compiler

```
#!/bin/bash
COMPILER=${DCOMPILER:=dmd}
VERSION=${DVERSION:=latest}
TOOL=${DTOOL:=${COMPILER}}

if [ "${TOOL}" = "ldc" ]; then
  TOOL='ldc2'
fi

if [ -n "${verbose}" ]; then
  echo "Compiler ${COMPILER} in Version ${VERSION} using ${TOOL}"
fi

if [ -n "${USE_LOCAL_USER}" ]; then
  OPTIONS="-e USER -e HOME -e LOCAL_USER_ID=`id -u $USER` -e LOCAL_GROUP_ID=`id -g $USER`"
fi
if [ -n "${FORCE_PULL}" ]; then
  docker pull dlanguage/${COMPILER}:${VERSION} 
fi
docker run --rm -ti ${OPTIONS:=} -w /user -v $(pwd):/user dlanguage/${COMPILER}:${VERSION} ${TOOL} $@
```
