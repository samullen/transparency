class AddRemoteIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remote_id, :string, :limit => 128
    add_index :users, :remote_id
  end

end
