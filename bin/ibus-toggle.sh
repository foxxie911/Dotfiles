#!/bin/sh

CURRENT=$(ibus engine)
BANGLA="OpenBangla"
ENGLISH="xkb:us::eng"

if [ $CURRENT == $ENGLISH ]; then
	ibus engine $BANGLA
else
	ibus engine $ENGLISH
fi
