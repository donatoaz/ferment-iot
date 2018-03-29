$redis = Redis.new(Rails.application.config_for(:redis))
Resque.redis = $redis
