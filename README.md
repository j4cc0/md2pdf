# md2pdf

Markdown to PDF using Pandoc via HTML (wkhtmltopdf) and CSS template

## Installation

### Prerequisites

`apt install pandoc wkhtmltopdf`

### md2pdf

Clone this git repo:  
`git clone https://github.com/j4cc0/md2pdf.git`

Set md2pdf.sh as executable:  
`cd md2pdf; chmod 755 md2pdf.sh`

## Usage

`md2pdf.sh <file-in-markdown> <destination-file.pdf>`

## Example

```
# ./md2pdf.sh https://commandlinekings.github.io/permx-walkthrough.md permx-walkthrough.pdf
[WARNING] This document format requires a nonempty <title> element.
  Defaulting to 'permx-walkthrough' as the title.
  To specify a title, use 'title' in metadata or --metadata title="...".
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
Loading page (1/2)
Printing pages (2/2)
Done
```

## Issues

NOTE: wkhtmltopdf may require an X11 display / X11 forwarding. If unavailable, resulting in the following error message:

```
(wkhtmltopdf:2944): Gtk-WARNING **: 10:56:27.308: cannot open display: localhost:11.0
Error producing PDF.
```




