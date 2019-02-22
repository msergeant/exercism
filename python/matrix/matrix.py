class Matrix(object):
    def __init__(self, matrix_string):
        matrix_rows = matrix_string.split('\n')
        self.rows = list(
            map(
                self._build_row, matrix_rows
            )
        )

    def row(self, index):
        return self.rows[index - 1]

    def column(self, index):
        return list(
            map(
                lambda x: x[index - 1], self.rows
            )
        )

    def _build_row(self, row_string):
        return list(
            map(
                lambda x: int(x), row_string.split()
            )
        )

