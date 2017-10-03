// Package erratum demonstrates the use cases of error-handling
package erratum

const testVersion = 2

// Use opens resource o and then calls Frob on it
func Use(o ResourceOpener, input string) (err error) {
	var res Resource
	if res, err = o(); err != nil {
		for _, ok := err.(TransientError); ok; _, ok = err.(TransientError) {
			res, err = o()
		}

		if err != nil {
			return
		}
	}
	defer res.Close()

	defer func() {
		if r := recover(); r != nil {
			switch x := r.(type) {
			case FrobError:
				res.Defrob(x.defrobTag)
				err = x.inner
			default:
				err = r.(error)
			}
		}
	}()

	res.Frob(input)

	return
}
