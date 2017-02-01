//
// xlsx2csv.go is a command line utility to extract individual CSV files from "Sheets" in an excel file.
//
// @Author R. S. Doiel
//
// Copyright (c) 2017, Caltech
// All rights not granted herein are expressly reserved by Caltech.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
package main

import (
	"flag"
	"fmt"
	"os"
	"path"

	// CaltechLibrary packages
	"github.com/caltechlibrary/cli"
	"github.com/clatechlibrary/shelltools"

	// 3rd Party packages
	"github.com/tealeg/xlsx"
)

var (
	usage = `USAGE: %s [OPTIONS] EXCEL_WORKBOOK_NAME [SHEET_NAME]`

	description = `
SYNOPSIS

%s is a tool to extract individual Excel sheets as CSV output from an 
Excel workbook in the .xlsx format. CSV content is written to Stdout.
`

	examples = `
EXAMPLE

    %s my-workbook.xls "Sheet 1" > sheet1.csv

This would get the first sheet from the workbook and save it as a CSV file.
`

	// Standard Options
	showHelp    bool
	showLicense bool
	showVersion bool

	// Application Options
	showSheetCount bool
	showSheetNames bool
	outputFilename string
)

func showSheetCount(workbookName string) (int, error) {
	return 0, fmt.Errorf("showSheetCount() not implemented")
}

func showSheetNames(workbookName string) ([]string, error) {
	return 0, fmt.Errorf("showSheetNames() not implemented")
}

func init() {
	flag.BoolVar(&showHelp, "h", false, "display help")
	flag.BoolVar(&showLicense, "l", false, "display license")
	flag.BoolVar(&showVersion, "v", false, "display version")

	flag.BoolVar(&showSheetCount, "c", false, "display number of sheets in Excel Workbook")
	flag.BoolVar(&showSheetNames, "n", false, "display sheet names in Excel W9rkbook")
}

func main() {
	appName := path.Base(os.Args[0])
	flag.Parse()
	args := flag.Args()

	// Configuration and command line interation
	cfg := cli.New(appName, appName, fmt.Sprintf(shelltools.LicenseText, appName, shelltools.Version), shelltools.Version)
	cfg.UsageText = fmt.Sprintf(usage, appName)
	cfg.DescriptionText = fmt.Sprintf(description, appName)
	cfg.ExampleText = fmt.Sprintf(examples, appName)

	if showHelp == true {
		fmt.Println(cfg.Usage())
		os.Exit(0)
	}

	if showLicense == true {
		fmt.Println(cfg.License())
		os.Exit(0)
	}

	if showVersion == true {
		fmt.Println(cfg.Version())
	}

	if len(args) < 1 {
		fmt.Println(cfg.Usage())
		fmt.Fprintln(os.Stderr, "Missing Excel Workbook names")
		os.Exit(1)
	}

	workBookName := args[0]
	if showSheetCount == true {
		if cnt, err := showSheetCount(workBookName); err == nil {
			fmt.Printf("%d", cnt)
			os.Exit(0)
		} else {
			fmt.Fprintf(os.Stderr, "%s, %s\n", workBookName, err)
			os.Exit(1)
		}
	}

	if showSheetNames == true {
		if names, err := showSheetNames(workBookName); err == nil {
			fmt.Println(strings.Join(names, "\n"))
			os.Exit(0)
		} else {
			fmt.Fprintf(os.Stderr, "%s, %s\n", workBookName, err)
			os.Exit(1)
		}
	}

	if len(args) < 2 {
		fmt.Fprintf(os.Stderr, "Missing worksheet name\n")
		os.Exit(1)
	}
	for i, sheetName := range args[1:] {
		src, err := xlsx2CSV(workBookName, sheetName)
		if err != nil {
			fmt.Fprintf(os.Stderr, "%s, %s, %s\n", workBookName, sheetName, err)
			os.Exit(1)
		}
		fmt.Println(src)
	}
}
