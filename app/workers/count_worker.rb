class CountWorker
  include Sidekiq::Worker

  def perform(*args)
    example = Example.find_or_initialize_by(name: 'sidekiq#index')
    page_count = (example.count || 0) + 1

    example.update(count: page_count)
  end
end
