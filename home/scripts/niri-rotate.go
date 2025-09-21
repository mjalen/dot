//usr/bin/env go run "$0" "$@"; exit "$?"
package main

import (
	"fmt"	
	"github.com/bitfield/script"	
)

func main() {
	script.Exec("ls").Stdout();
}