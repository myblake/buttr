require 'spec_helper'

describe Wallet do
  let(:user) { User.new }
  let(:wallet) { user.build_wallet }

  it "should show balance" do
    wallet.balance = 10
    expect(wallet.balance).to eq 10
  end

  it "should store underlying value in cents" do
    wallet.balance = 10
    expect(wallet.balance_cents).to eq 1000
  end

  it "should increase balance when credited" do
    wallet.balance = 10
    wallet.credit 1
    expect(wallet.balance).to eq 11
  end

  it "should decrease balance when debited by less than the balance" do
    wallet.balance = 10
    wallet.debit 1
    expect(wallet.balance).to eq 9
  end

  it "should raise an error if dollar amounts are negative" do
    wallet.balance = 10
    expect {wallet.credit(-3)}.to raise_error(ArgumentError)
    expect {wallet.credit('foo')}.to raise_error(ArgumentError)
  end

  context "transactions" do
    it "should log transactions" do
      wallet.balance = 10
      expect(wallet.transactions.size).to eq 0
      wallet.credit(3)
      expect(wallet.transactions.size).to eq 1
    end
    it "should be of the right type and amount" do 
      wallet.balance = 10
      wallet.credit(3)
      expect(wallet.transactions.first.transaction_type).to eq 'credit'
      expect(wallet.transactions.first.amount_cents).to eq 300
    end
  end
end
