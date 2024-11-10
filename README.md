# md2pdf

Markdown to PDF using Pandoc via HTML (wkhtmltopdf) and CSS template

## Installation

`apt install pandoc wkhtmltopdf`

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



