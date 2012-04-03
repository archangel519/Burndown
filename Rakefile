namespace :db do
  desc "Migrate the database"
  
  task :environment do
    require 'active_record'
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "burndown",
      :password => "HappyBunnyFuzzySquirrel",
      :database => "burndown"
    )
  end
  
  task :migrate => :environment do
    require 'logger'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end