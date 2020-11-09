class ChangrPriceToMoneyOnProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :price
    add_monetize :profiles, :price
  end
end
