class User
  attr_accessor :id, :name, :email
  attr_reader :balance

  def initialize(id:, name:, email:, balance: 0.0)
    @id = id
    @name = name
    @email = email
    @balance = balance
  end

  def has_sufficient_funds?(amount)
    @balance >= amount
  end

  def deduct_balance(amount)
    raise "Insufficient funds" unless has_sufficient_funds?(amount)
    @balance -= amount
  end

  def add_balance(amount)
    @balance += amount
  end

  def pay(amount)
    return false unless has_sufficient_funds?(amount)
    @balance -= amount
    true
  end

end 