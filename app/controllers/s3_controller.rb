class S3Controller < ApplicationController
  before_action :create_bucket!
  before_action :fetch_count!

  def index
    # writes to s3
    response = S3.client.put_object(
      bucket: bucket_name,
      key: key,
      body: { count: @page_count }.to_json
    )
    @etag = response.etag
  end

  private

  def bucket_name
    'rails-docker-test'
  end

  def key
    'count'
  end

  def create_bucket!
    return if S3.client.list_buckets.buckets.map(&:name).include? bucket_name

    S3.client.create_bucket( bucket: bucket_name)
  end

  def fetch_count!
    unless S3.client.list_objects_v2(bucket: bucket_name).contents.map(&:key).include? key
      @page_count = 1
      return
    end

    begin
      resp = S3.client.get_object(bucket:bucket_name, key: key)
      @page_count = JSON.parse(resp.body.read)['count'] + 1

    rescue => e
      @page_count = 1
      @error = e.message
    end
  end
end
