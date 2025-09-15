#!/bin/bash
export RELPATH=$(dirname $0)/../..;
if which menubar 2>/dev/null 1>&2;then
  menubar=$(which menubar)
else
  menubar=$RELPATH/menubar
fi
$menubar -s "$NAME"