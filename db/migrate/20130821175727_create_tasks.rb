class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :project, :null => false
      t.string :name, :limit => 128, :null => false
      t.string :remote_id, :limit => 128
      t.belongs_to :category
      t.boolean :billable
      t.float :hours, :default => 0.0
      t.datetime :started_at
      t.timestamps
    end

    add_index :tasks, :project_id
    add_index :tasks, :category_id
    add_index :tasks, :started_at
  end
end
