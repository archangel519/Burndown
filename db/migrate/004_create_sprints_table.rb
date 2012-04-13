class CreateSprintsTable < ActiveRecord::Migration
  def up
    create_table :sprints do |s|
      s.references  :release
      s.integer   :id
      s.string    :title
      s.string    :description
      s.date      :start_date
      s.date      :end_date
      s.integer   :status, :default => 0
    end
  end

  def down
    drop_table :sprints
  end
end