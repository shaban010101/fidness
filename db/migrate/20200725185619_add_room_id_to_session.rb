class AddRoomIdToSession < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :room_id, :uuid, null: false, default: 'uuid_generate_v4()'
  end
end
