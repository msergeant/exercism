// Package pascal provides functionality for computing rows of pascals triangle
package pascal

const testVersion = 1

func Triangle(row int) (triangle [][]int) {
	lastRow, currentRow := []int{1}, []int{1}
	for i := 0; i < row; i, currentRow = i+1, []int{1} {
		triangle = append(triangle, lastRow)
		for j := 0; j < len(lastRow)-1; j++ {
			currentRow = append(currentRow, lastRow[j]+lastRow[j+1])
		}
		currentRow = append(currentRow, 1)
		lastRow = currentRow
	}
	return
}
