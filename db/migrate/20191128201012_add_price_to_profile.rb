class AddPriceToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :price, :decimal, precision: 8, scale: 2
  end
end
