// Package queenattack is used to detect whether or not 2 queens can attack each other
package queenattack

import (
	"fmt"
)

const testVersion = 2

// CanQueenAttack returns true if the queens are in position to attack
func CanQueenAttack(w string, b string) (canAttack bool, err error) {
	if len(w) != 2 || len(b) != 2 {
		err = fmt.Errorf("Invalid Square")
		return
	}
	wCol, wRow := intColumnRow(w)
	bCol, bRow := intColumnRow(b)
	if invalidCol(wCol) || invalidCol(bCol) || invalidRow(wRow) || invalidRow(bRow) {
		err = fmt.Errorf("Invalid Square")
		return
	}
	if w == b {
		err = fmt.Errorf("Queens cannot occupy the same square")
		return
	}

	if wCol == bCol {
		canAttack = true
	}
	if wRow == bRow {
		canAttack = true
	}

	// diagonol
	colDiff, rowDiff := wCol-bCol, wRow-bRow
	if colDiff*colDiff == rowDiff*rowDiff {
		canAttack = true
	}
	return
}

func intColumnRow(square string) (col byte, row byte) {
	col = square[0]
	row = square[1]
	return
}

func invalidRow(row byte) bool {
	if row < '1' || row > '8' {
		return true
	}

	return false
}

func invalidCol(col byte) bool {
	if col < 'a' || col > 'h' {
		return true
	}

	return false
}
