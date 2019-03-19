#!/bin/bash

PY=python

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

    # Install some custom requirements on OS X
    # e.g. brew install pyenv-virtualenv
    brew update > /dev/null
    echo TOXENV:${TOXENV}
    case "${TOXENV}" in
        py2)
            brew uninstall python || echo "not exist python"
            brew install python
            echo "Success install python3"
            PY=python2
            ;;
        py3)
            brew uninstall python || echo "not exist python"
            brew install python3
            PY=python3
            echo "Success install python3"
            ;;
    esac
else
    # Install some custom requirements on Linux
    echo "";
fi

echo $(${PY} --version)
export PYLTPVER=$(${PY} setup.py --version)
$PY setup.py build
$PY setup.py sdist
cd dist/
tar zxvf pyltp-$PYLTPVER.tar.gz
cd pyltp-$PYLTPVER
$PY setup.py build
