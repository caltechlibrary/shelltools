#
# Simple Makefile
#
PROJECT = shelltools

VERSION = $(shell grep -m1 'Version = ' $(PROJECT).go | cut -d\"  -f 2)

BRANCH = $(shell git branch | grep '* ' | cut -d\  -f 2)

build: bin/findfile bin/finddir bin/mergepath bin/reldate bin/range bin/timefmt bin/urlparse

bin/findfile: shelltools.go cmds/findfile/findfile.go
	go build -o bin/findfile cmds/findfile/findfile.go 

bin/finddir: shelltools.go cmds/finddir/finddir.go
	go build -o bin/finddir cmds/finddir/finddir.go 

bin/mergepath: shelltools.go cmds/mergepath/mergepath.go
	go build -o bin/mergepath cmds/mergepath/mergepath.go 

bin/reldate: shelltools.go cmds/reldate/reldate.go
	go build -o bin/reldate cmds/reldate/reldate.go 

bin/range: shelltools.go cmds/range/range.go
	go build -o bin/range cmds/range/range.go 

bin/timefmt: shelltools.go cmds/timefmt/timefmt.go
	go build -o bin/timefmt cmds/timefmt/timefmt.go 

bin/urlparse: shelltools.go cmds/urlparse/urlparse.go
	go build -o bin/urlparse cmds/urlparse/urlparse.go 

website:
	./mk-website.bash

status:
	git status

save:
	if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

refresh:
	git fetch origin
	git pull origin $(BRANCH)

publish:
	./mk-website.bash
	./publish.bash

clean: 
	if [ -d bin ]; then /bin/rm -fR bin; fi
	if [ -d dist ]; then /bin/rm -fR dist; fi

install:
	env GOBIN=$(HOME)/bin go install cmds/findfile/findfile.go
	env GOBIN=$(HOME)/bin go install cmds/finddir/finddir.go
	env GOBIN=$(HOME)/bin go install cmds/mergepath/mergepath.go
	env GOBIN=$(HOME)/bin go install cmds/reldate/reldate.go
	env GOBIN=$(HOME)/bin go install cmds/range/range.go
	env GOBIN=$(HOME)/bin go install cmds/timefmt/timefmt.go
	env GOBIN=$(HOME)/bin go install cmds/urlparse/urlparse.go

dist/linux-amd64:
	mkdir -p dist/bin
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/findfile cmds/findfile/findfile.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/finddir cmds/finddir/finddir.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/mergepath cmds/mergepath/mergepath.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/reldate cmds/reldate/reldate.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/range cmds/range/range.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/timefmt cmds/timefmt/timefmt.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/bin/urlparse cmds/urlparse/urlparse.go
	cd dist && zip -r $(PROJECT)-$(VERSION)-linux-amd64.zip README.md LICENSE INSTALL.md docs/* bin/*
	rm -fR dist/bin


dist/macosx-amd64:
	mkdir -p dist/bin
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/findfile cmds/findfile/findfile.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/finddir cmds/finddir/finddir.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/mergepath cmds/mergepath/mergepath.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/reldate cmds/reldate/reldate.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/range cmds/range/range.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/timefmt cmds/timefmt/timefmt.go
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/bin/urlparse cmds/urlparse/urlparse.go
	cd dist && zip -r $(PROJECT)-$(VERSION)-macosx-amd64.zip README.md LICENSE INSTALL.md docs/* bin/*
	rm -fR dist/bin

dist/windows-amd64:
	mkdir -p dist/bin
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/findfile.exe cmds/findfile/findfile.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/finddir.exe cmds/finddir/finddir.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/mergepath.exe cmds/mergepath/mergepath.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/reldate.exe cmds/reldate/reldate.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/range.exe cmds/range/range.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/timefmt.exe cmds/timefmt/timefmt.go
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o dist/bin/urlparse.exe cmds/urlparse/urlparse.go
	cd dist && zip -r $(PROJECT)-$(VERSION)-windows-amd64.zip README.md LICENSE INSTALL.md docs/* bin/*
	rm -fR dist/bin

dist/raspbian-arm7:
	mkdir -p dist/bin
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/findfile cmds/findfile/findfile.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/finddir cmds/finddir/finddir.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/mergepath cmds/mergepath/mergepath.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/reldate cmds/reldate/reldate.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/range cmds/range/range.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/timefmt cmds/timefmt/timefmt.go
	env CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o dist/bin/urlparse cmds/urlparse/urlparse.go
	cd dist && zip -r $(PROJECT)-$(VERSION)-raspbian-arm7.zip README.md LICENSE INSTALL.md docs/* bin/*
	rm -fR dist/bin

distribute_docs:
	mkdir -p dist/docs
	cp -v README.md dist/
	cp -v LICENSE dist/
	cp -v INSTALL.md dist/
	cp -v docs/*.md dist/docs/
	rm dist/docs/nav.md
	cp -vR demos dist/

release: distribute_docs dist/linux-amd64 dist/macosx-amd64 dist/windows-amd64 dist/raspbian-arm7

