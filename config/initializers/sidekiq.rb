Sidekiq::Extensions.enable_delay!


SIDEKIQ_REDIS_HOST = ENV['REDIS_HOST'] || 'localhost'
SIDEKIQ_REDIS_PORT = ENV['REDIS_SERVICE_SERVICE_PORT'] || '6379'
SIDEKIQ_REDIS_URL = "redis://#{ SIDEKIQ_REDIS_HOST }:#{ SIDEKIQ_REDIS_PORT }/0"

Sidekiq.configure_server do |config|
  config.redis = { url: SIDEKIQ_REDIS_URL }
end

Sidekiq.configure_client do |config|
  config.redis = { url: SIDEKIQ_REDIS_URL }
end

RailsDocker::Application.config.active_job.queue_adapter = :sidekiq