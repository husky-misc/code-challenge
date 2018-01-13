class CreateComputeHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :compute_histories do |t|
      t.text :result

      t.timestamps
    end
  end
end
