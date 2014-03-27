class Wallet
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  embedded_in :user
  embeds_many :transactions

  # maybe use money gem instead?
  field :balance_cents, type: Integer, default: 0

  def balance
    balance_cents/100.0
  end

  def balance=(new_balance)
    self.balance_cents = (new_balance * 100).to_i
  end

  # debits wallet, returns balance
  def debit(dollar_amount, note=nil)
    raise ArgumentError, "dollar amount must be non negative number" unless dollar_amount.is_a?(Numeric) && dollar_amount >= 0
    self.transactions << Transaction.new(amount_cents: dollar_amount*100, transaction_type: 'debit', note: note)
    self.balance = self.balance - dollar_amount
  end
  
  # credits wallet, returns balance
  def credit(dollar_amount, note=nil)
    raise ArgumentError, "dollar amount must be non negative number" unless dollar_amount.is_a?(Numeric) && dollar_amount >= 0
    self.transactions << Transaction.new(amount_cents: dollar_amount*100, transaction_type: 'credit', note: note)
    self.balance = self.balance + dollar_amount
  end
end
