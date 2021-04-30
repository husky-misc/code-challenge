class Kill < ApplicationRecord
  belongs_to :killer
  belongs_to :killed
  belongs_to :weapon
end
