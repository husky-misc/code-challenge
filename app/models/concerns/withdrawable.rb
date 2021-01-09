module Withdrawable
  extend ActiveSupport::Concern

  included do
    def withdraw!(amount:)
      self.update!(spent_limit: self.spent_limit - amount.to_i)
    end
  end
end
