class SetAppropriateDefaults < ActiveRecord::Migration
  def up
    #releases table
    change_column :releases, :title, :string, { :null => false, :default => '' }
    change_column :releases, :status, :integer, { :null => false, :default => 1 }
    #sprints table
    change_column :sprints, :release_id, :integer, { :null => false }
    change_column :sprints, :title, :string, { :null => false, :default => '' }
    change_column :sprints, :status, :integer, { :null => false, :default => 1 }
    #stories table
    change_column :stories, :name, :string, { :null => false, :default => 'New Story' }
    change_column :stories, :points, :integer, { :null => false, :default => 1 }
    add_column    :stories, :sprint_id, :integer, { :null => false }
    #tasks table
    change_column :tasks, :story_id, :integer, { :null => false }
    change_column :tasks, :title, :string, { :null => false, :default => '' }
    change_column :tasks, :status, :integer, { :null => false, :default => 1 }
  end

  def down
    #releases table
    change_column :releases, :title, :string, { :null => true, :default => nil }
    change_column :releases, :status, :integer, { :null => true, :default => 0 }
    #sprints table
    change_column :sprints, :release_id, :integer, { :null => true }
    change_column :sprints, :title, :string, { :null => true, :default => nil }
    change_column :sprints, :status, :integer, { :null => true, :default => 0 }
    #stories table
    change_column :stories, :name, :string, { :null => true, :default => nil }
    change_column :stories, :points, :integer, { :null => true, :default => 0 }
    remove_column :stories, :sprint_id
    #tasks table
    change_column :tasks, :story_id, :integer, { :null => true }
    change_column :tasks, :title, :string, { :null => true, :default => nil }
    change_column :tasks, :status, :integer, { :null => true, :default => 0 }
  end
end