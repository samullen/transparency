class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :user, :null => false
      t.string :name, :limit => 128, :null => false
      t.string :remote_id, :limit => 128
      t.timestamps
    end

    add_index :projects, :user_id
  end
end
