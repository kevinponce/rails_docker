require 'aws-sdk-s3'
# Examples:
# # Creat Bucket
# bucket_name = 'rails-docker-test'
# unless S3.client.list_buckets.buckets.map(&:name).include? bucket_name
#   S3.client.create_bucket( bucket: bucket_name)
# end

# # List buckets
# response = S3.client.list_buckets
# response.buckets.each do |bucket|
#   puts "#{bucket.creation_date} #{bucket.name}"
# end

# S3.client.list_objects_v2(bucket: bucket_name)

# # Upload Object
# object_key = 'example.txt'
# response = S3.client.put_object(
#   bucket: bucket_name,
#   key: object_key,
#   body: 'abc123'
# )
# response.etag

# # List Object ins bucket
# S3.client.list_objects_v2(bucket: bucket_name)

# # Delete Object
# response = S3.client.delete_objects(
#   bucket: bucket_name,
#   delete: {
#     objects: [{
#       key: object_key
#     }]
#   }
# )
# response.deleted.count == 1

class S3
  class << self
    def endpoint
      "http://#{ENV['S3_SERVICE_HOST']}:#{ENV['S3_SERVICE_PORT']}"
    end

    def client
      @client ||= Aws::S3::Client.new(
        endpoint: endpoint,
        region: 'us-east-1',
        credentials: Aws::Credentials.new('XXX', 'XXX'),
      )
    end
  end
end
