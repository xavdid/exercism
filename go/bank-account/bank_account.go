package account

import "sync"

type Account struct {
	open    bool
	balance int64
	mu      sync.Mutex
}

func Open(amount int64) *Account {
	if amount < 0 {
		return nil
	}

	return &Account{
		open:    true,
		balance: amount,
	}
}

func (a *Account) Balance() (int64, bool) {
	a.mu.Lock()
	defer a.mu.Unlock()

	if a.open {
		return a.balance, true
	}
	return 0, false
}

// also used for withdrawals
func (a *Account) Deposit(amount int64) (int64, bool) {
	a.mu.Lock()
	defer a.mu.Unlock()

	if amount < 0 && -1*amount > a.balance {
		return 0, false
	}

	if a.open {
		a.balance += amount
		return a.balance, true
	}

	return 0, false
}

func (a *Account) Close() (int64, bool) {
	a.mu.Lock()
	defer a.mu.Unlock()

	if a.open {
		a.open = false

		closing_balance := a.balance
		a.balance = 0
		return closing_balance, true
	}

	return 0, false
}
