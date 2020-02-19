class Transaction < ApplicationRecord
  enum transaction_type: [:credit, :debit]
  belongs_to :bank_account, touch: true

  scope :days_ago, ->(days) { where('created_at > ?',days.to_i.days.ago) }

  default_scope { order(created_at: :desc) }
  self.per_page = 20
end
