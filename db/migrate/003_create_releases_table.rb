class CreateReleasesTable < ActiveRecord::Migration
  def up
    create_table :releases do |r|
      r.integer   :id
      r.string    :title
      r.string    :description
      r.integer   :status, :default => 0
    end
  end

  def down
    drop_table :releases
  end
end