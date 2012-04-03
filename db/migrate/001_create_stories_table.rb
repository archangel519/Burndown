class CreateStoriesTable < ActiveRecord::Migration
  def up
    create_table :stories do |s|
      s.integer   :id
      s.string    :name
      s.integer   :points
      s.string    :description
    end
  end

  def down
    drop_table :stories
  end
end