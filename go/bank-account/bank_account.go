// Package account simulates a bank account
package account

import (
	"sync"
)

const testVersion = 1

type Account struct {
	open         bool
	amount       int
	accountMutex sync.Mutex
}

// Open returns a newly created account
func Open(amount int) *Account {
	if amount < 0 {
		return nil
	}
	return &Account{amount: amount, open: true}
}

// Balance returns the current balance
func (a *Account) Balance() (int, bool) {
	if !a.open {
		return -1, false
	}

	return a.amount, true
}

// Close closes the account and returns the balance
func (a *Account) Close() (int, bool) {
	a.accountMutex.Lock()
	if !a.open {
		a.accountMutex.Unlock()
		return 0, false
	}
	a.open = false
	a.accountMutex.Unlock()
	return a.amount, true
}

// Deposit adds money to the current balance and returns the current balance
func (a *Account) Deposit(d int) (int, bool) {
	a.accountMutex.Lock()
	if !a.open || (a.amount+d < 0) {
		a.accountMutex.Unlock()
		return -1, false
	}
	a.amount += d
	a.accountMutex.Unlock()
	return a.amount, true
}
