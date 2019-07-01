require 'pry'
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    if self.sender.valid? && self.receiver.valid? then true else false end
  end

  def sufficient_funds?
    sender_balance = self.sender.balance
    if (sender_balance -= self.amount) < 0 then return false else return true end
  end

  def execute_transaction
    if self.sufficient_funds? && self.valid? && self.status != 'complete'
      # decrease balance of sender
      self.sender.balance -= self.amount

      # increase balance of receiver
      self.receiver.balance += self.amount
      self.status = 'complete'
    else
      self.status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = 'reversed'
    end
  end
end
