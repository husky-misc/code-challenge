class ChangeCreditCardToChargeableOnTransaction < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :chargeable, polymorphic: true, index: true, null: false
    remove_reference :transactions, :credit_card
  end
end
