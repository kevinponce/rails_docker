class PgController < ApplicationController
  def index
    example = Example.find_or_initialize_by(name: 'pg#index')
    @page_count = (example.count || 0) + 1

    example.update(count: @page_count)
  end
end
