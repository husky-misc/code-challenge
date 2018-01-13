class AddIpToNumber < ActiveRecord::Migration[5.1]
  def change
    add_reference :numbers, :ip, foreign_key: true
  end
end
