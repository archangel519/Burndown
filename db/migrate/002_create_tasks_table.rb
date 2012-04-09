class CreateTasksTable < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.references :story
      t.integer   :id
      t.string    :title
      t.string    :description
      t.decimal   :hours, :precision => 6, :scale => 2, :default => 0.25
      t.integer   :owner
      t.integer   :status, :default => 0
    end
  end

  def down
    drop_table :tasks
  end
end