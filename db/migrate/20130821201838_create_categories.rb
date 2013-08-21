class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false, :limit => 128
      t.string :remote_id
      t.timestamps
    end

    add_index :categories, :name
  end
end
