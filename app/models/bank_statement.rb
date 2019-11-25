class BankStatement < ApplicationRecord
    has_many :transactions

    accepts_nested_attributes_for :transactions, allow_destroy: true

    def as_json(options={})
        super(options)
    end
end
