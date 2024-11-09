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

# -- Functions

clean_exit() {
	if [ "x${TMPF}x" = "xx" ]; then
		echo "Internal error" >&2
		return 1
	fi
	if [ ! -f "$TMPF" ]; then
		echo "Internal error. Missing $TMPF" >&2
		return 1
	fi
	rm -f "$TMPF" &>/dev/null || \
		echo "Removing $TMPF had no clean exit. Please check" >&2
	exit $?
}

# -- Parameter handling and sanity checking

IN="$1"

if [ "x${IN}x" = "xx" ]; then
	echo "Missing parameter. Aborted" >&2
	exit 1
fi

if echo "$IN" | grep '://' &>/dev/null; then
	# Probably an online resource, let pandoc handle it
	:
else
	# Likely a local file
	if [ ! -r "$IN" ]; then
		echo "$IN not readable. Does it exist? Aborted" >&2
		exit 1
	fi
fi

OUT="$2"

if [ "x${OUT}x" = "xx" ]; then
	OUT="$(basename \"$IN\" | sed 's/\..*$//').$TYPE"
	if [ "x${OUT}x" ]; then
		echo "Missing output filename. Aborted" >&2
		exit 1
	fi
fi

if [ -f "$OUT" ]; then
	echo "$OUT already exists. Refusing to overwrite. Please fix. Aborted" >&2
	exit 1
fi

touch "$OUT"
if [ "$?" -ne 0 ]; then
	echo "Failed to write $OUT. Please check. Aborted" >&2
	exit 1
fi

# -- Main

TMPF="$(mktemp)"

cat <<-___EOF___>"$TMPF"
$CSS
___EOF___

case $TYPE in
[Pp][Dd][Ff])
	pandoc -t html5 --css="$TMPF" "$IN" -o "$OUT" -s --pdf-engine=wkhtmltopdf
	rm -f "$TMPF" &>/dev/null
	;;
*)
	echo "$TYPE is not implemented. Sorry. Aborted" >&2
	exit 1
	;;
esac




