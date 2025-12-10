require 'pry'
module SavingsAccount
  def self.interest_rate(balance)
    if (0...1000).include?(balance)
      0.5
    elsif 1000 <= balance && balance < 5000
      1.621
    elsif balance >= 5000
      2.475
    elsif balance < 0
      3.213
    end
  end

  def self.annual_balance_update(balance)
    balance + balance * (interest_rate(balance) / 100)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0
    until current_balance >= desired_balance
      current_balance = annual_balance_update(current_balance)
      years += 1
    end
    years
  end
end
