class ChangeRoleIdToAllowNullInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role_id, :bigint, null: true
  end
end
