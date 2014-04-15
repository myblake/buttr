class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  #TODO migrate to own collection and allow use with other financials (such as tips etc)
  embedded_in :wallet
  field :amount_cents, type: Integer, default: 0
  field :transaction_type, type: String
  field :note, type: String
end
