local BankAccount = {
  new = function(self)
    local o = {
      _open = true,
      _balance = 0
    }

    setmetatable(o, self)
    self.__index = self

    return o
  end,

  balance = function(self)
    return self._balance
  end,

  deposit = function(self, amount)
    if amount <= 0 then
      error("amount must be positive")
    end
    if not self._open then
      error("operation on closed account")
    end
    self._balance = self._balance + amount
  end,

  withdraw = function(self, amount)
    if amount <= 0 or amount >= self._balance then
      error("amount must be positive and less than balance")
    end
    if not self._open then
      error("operation on closed account")
    end

    self._balance = self._balance - amount
  end,

  close = function(self)
    self._open = false
  end
}



return BankAccount
