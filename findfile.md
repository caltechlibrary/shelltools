[![Go Report Card](http://goreportcard.com/badge/rsdoiel/fsutils)](http://goreportcard.com/report/rsdoiel/fsutils)
[![License](https://img.shields.io/badge/License-BSD%202--Clause-blue.svg)](https://opensource.org/licenses/BSD-2-Clause)


# findfile

Lists files recursively (including in subdirectories). Can be constrained
by prefix, suffix and basename contents (e.g. contains).

## USAGE

```
    findfile [OPTIONS] [TARGET_FILENAME] [DIRECTORIES_TO_SEARCH]
```

Finds files based on matching prefix, suffix or contained text in base filename.

```
    -c, -contains	find file(s) based on basename containing text
    -d, -depth	    limit depth of directories walked
    -e, -error-stop	Stop walk on file system errors (e.g. permissions)
    -f, -full-path	list full path for files found
    -h, -help	    display this help message
    -l, -license	display license information
    -m, -mod-time	display file modification time before the path
    -p, -prefix	    find file(s) based on basename prefix
    -s, -suffix	    find file(s) based on basename suffix
    -v, -version	display version message
```

