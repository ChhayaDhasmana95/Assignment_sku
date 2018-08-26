class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.integer :sku_denominations
      t.string :sku_combinations
      t.integer :user_id

      t.timestamps
    end
  end
end
