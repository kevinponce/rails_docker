class SidekiqController < ApplicationController
  def index
    example = Example.find_or_initialize_by(name: 'sidekiq#index')
    @page_count = (example.count || 0) + 1

    CountWorker.perform_async
  end
end
