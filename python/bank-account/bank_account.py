class BankAccount:
    _open = False
    _balance = 0

    def _assert_open(self):
        if not self._open:
            raise ValueError("account not open")

    def get_balance(self):
        self._assert_open()
        return self._balance

    def open(self):
        if self._open:
            raise ValueError("account already open")
        self._open = True

    def deposit(self, amount):
        self._assert_open()

        if amount < 0:
            raise ValueError("amount must be greater than 0")

        self._balance += amount

    def withdraw(self, amount):
        self._assert_open()

        if amount > self._balance:
            raise ValueError("amount must be less than balance")

        if amount < 0:
            raise ValueError("amount must be greater than 0")

        self._balance -= amount

    def close(self):
        self._assert_open()
        self._open = False
        self._balance = 0
