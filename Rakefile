namespace :db do
  desc "Migrate the database"
  
  task :environment do
    require 'active_record'
    require 'yaml'
    db_config_path = File.join(File.dirname(__FILE__), '/config/db_config.yml')
    db_config = YAML::load(File.open(db_config_path))
    ActiveRecord::Base.establish_connection(db_config)
  end
  
  task :migrate => :environment do
    require 'logger'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end
 
task :rspec do
  sh 'bundle exec rspec -c'
end