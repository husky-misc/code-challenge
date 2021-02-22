class Gun < ApplicationRecord
    validates :name, presence: :true
    has_one :kill_log
end
