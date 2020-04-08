class AddExternalPaymentIdToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column(:sessions, :external_id, :string)
    add_column(:sessions, :currency, :string)
    add_column(:sessions, :price, :decimal, precision: 8, scale: 2)
    add_column(:sessions, :payment_status, :string)
  end
end
