class Kill < ApplicationRecord
  belongs_to :match
  belongs_to :killer, class_name: "Player", optional: true
  belongs_to :killed, class_name: "Player"
  belongs_to :weapon, optional: true
end
