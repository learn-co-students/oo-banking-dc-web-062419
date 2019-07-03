class BankAccount
  @@all = []
  attr_accessor :balance, :status
  attr_reader :name

  def initialize(name,balance=1000,status="open")
    @name = name
    @balance = 1000
    @status = "open"
    self.class.all << self
  end

  def self.all
    @@all
  end

  def display_balance
    "Your balance is $#{self.balance}."
  end

  def deposit(amount)
    self.balance += amount
  end

  def valid?
    self.status == "open" && @balance > 0
  end

  def close_account
    self.status = "closed"
  end
end
