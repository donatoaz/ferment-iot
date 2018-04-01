$redis = Redis.new(Rails.application.config_for(:redis))

Resque.redis = $redis

require 'resque-scheduler'
require 'resque/scheduler/server'
require 'active_scheduler'

my_schedule = Rails.application.config_for(:schedule)
my_wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap my_schedule
Resque.schedule = my_wrapped_schedule

Resque.logger.level = Logger::DEBUG

# Open the new separate log file
logfile = File.open(File.join(Rails.root, 'log', 'resque.log'), 'a')

# Activate file synchronization
logfile.sync = true

Resque.logger = Logger.new(logfile)
