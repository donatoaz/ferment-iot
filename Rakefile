# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'active_scheduler'

task 'resque:setup' => :environment do
  Resque.before_fork = Proc.new { 
    ActiveRecord::Base.establish_connection

    # Open the new separate log file
    # logfile = File.open(File.join(Rails.root, 'log', 'resque.log'), 'a')

    # Activate file synchronization
    # logfile.sync = true

    # Create a new buffered logger
    # Resque.logger = ActiveSupport::BufferedLogger.new(logfile)
    # Resque.logger.level = Logger::DEBUG
    # Resque.logger.debug "Resque Logger Initialized!"
  }
end

Rails.application.load_tasks
