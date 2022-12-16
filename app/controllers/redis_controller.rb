class RedisController < ApplicationController
  def index
    redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_SERVICE_SERVICE_PORT'] || '6379')
    @page_count = (redis.get('count')&.to_i || 0) + 1

    redis.set('count', @page_count)
  end
end
