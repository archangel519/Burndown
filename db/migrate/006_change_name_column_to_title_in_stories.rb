class ChangeNameColumnToTitleInStories < ActiveRecord::Migration
  def up
    rename_column :stories, :name, :title
    change_column :stories, :title, :string, { :default => '' }
  end

  def down
    rename_column :stories, :title, :name
    change_column :stories, :name, :string, { :default => 'New Story' }
  end
end