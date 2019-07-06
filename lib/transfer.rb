require 'pry'

class Transfer

  attr_reader :sender, :receiver
  attr_accessor :status, :amount

    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end 
    
    def valid?
      self.receiver.valid? && self.sender.valid?
    end

    def sender_verification
        self.valid? == true && 
        self.status == "pending" && 
        self.sender.balance >= self.amount
    end
    
    def execute_transaction
      if self.sender_verification
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
      else
          self.status = "rejected"
          "Transaction rejected. Please check your account balance."
      end
    end

    def reverse_transfer
      if self.status == "complete"
          self.sender.balance += self.amount
          self.receiver.balance -= self.amount
          self.status = "reversed"
      else
          puts "You cannot reverse this transaction at this time"
      end
    end
end
