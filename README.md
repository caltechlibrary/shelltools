
# shelltools

Various utilities for simplifying work on the command line. 

+ [csvcols](csvcols.html) - converts commandline parameters into a CSV encoded row written to standard out
+ [findfile](findfile.html) - find files based on prefix, suffix or contained string
+ [finddir](finddir.html) - find directories based on prefix, suffix or contained string
+ [jsoncols](jsoncols.html) - a tool for exploring and extracting JSON values into columns
+ [mergepath](mergepath.html) - prefix, append, clip path variables
+ [pathparts](pathparts.html) - split a path into parts
+ [range](range.html) - emit a range of integers (useful for numbered loops in Bash)
+ [reldate](reldate.html) - display a relative date in YYYY-MM-DD format
+ [timefmt](timefmt.html) - format a time value based on Golang's time format language
+ [urlparse](urlparse.html) - split a URL into parts

Compiled versions are provided for Linux (amd64), Mac OS X (amd64),
Windows 10 (amd64) and Raspbian (ARM6, ARM7). See https://github.com/caltechlibrary/shelltools.

Use the utilities try "-help" option for a full list of options.


## Installation

_shelltools_ is go get-able.

```
    go get github.com/caltechlibrary/shelltools/...
```

Or see [INSTALL.md](install.html) for details for installing 
compiled versions of the programs.


