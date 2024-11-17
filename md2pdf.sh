#!/bin/bash
#Descr: md2pdf via pandoc and wkhtmltopdf including CSS template.
#Author: Jacco van Buuren <jaccovanbuuren at gmail dot com>
#Date: November 2024

# -- Globals, constants, etc.

TYPE="pdf"

CSS="
	body {
	  background-color: white;
	}

	pre {
	  white-space: pre;
	  white-space: pre-wrap;
	  word-wrap: break-word;
	  font-family: monospace, monospace;
	  font-size: 0.98em;
	  border: 1px solid #999;
	  padding: 0.5em;
	  page-break-inside: avoid;
	}
"

SCRIPT="$(basename $0 | sed 's/\..*$//')"

# -- Functions

warn() {
	echo "[!] $@" >&2
	return 0
}

die() {
	warn "$@. Aborted" >&2
	exit 1
}

clean_exit() {
	if [ "x${TMPF}x" = "xx" ]; then
		die "$SCRIPT internal error"
	fi
	if [ ! -f "$TMPF" ]; then
		die "$SCRIPT Internal error. Missing $TMPF"
	fi
	rm -f "$TMPF" &>/dev/null || \
		warn "$SCRIPT Removing $TMPF had no clean exit. Please check"
	exit $?
}

# -- Parameter handling and sanity checking

IN="$1"
OUT="$2"

if [ "x${IN}x" = "xx" ]; then
	die "Missing parameter"
fi

if echo "$IN" | grep '://' &>/dev/null; then
	# Probably an online resource, let pandoc handle it
	:
else
	# Likely a local file
	if [ ! -r "$IN" ]; then
		die "$IN not readable. Does it exist?"
	fi
fi

if [ "x${OUT}x" = "xx" ]; then
	OUT="$(basename \"$IN\" | sed 's/\..*$//').$TYPE"
	if [ "x${OUT}x" ]; then
		die "Missing output filename"
	fi
fi

if [ -f "$OUT" ]; then
	die "$OUT already exists. Refusing to overwrite. Please fix"
fi

touch "$OUT"
if [ "$?" -ne 0 ]; then
	die "Failed to write $OUT. Please check"
fi

# -- Main

TMPF="$(mktemp)"
trap clean_exit 1 2 3 5 6 15 19

cat <<-___EOF___>"$TMPF"
$CSS
___EOF___

case $TYPE in
[Pp][Dd][Ff])
	pandoc -t html5 --css="$TMPF" "$IN" -o "$OUT" -s --pdf-engine=wkhtmltopdf
	clean_exit
	;;
*)
	die "$TYPE is not implemented. Sorry"
	;;
esac




