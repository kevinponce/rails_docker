require 'aws-sdk-dynamodb'

class Dynamo
  class << self
    # Example: Dynamo.end_point
    def end_point
      if ENV['DYNAMODB_HOST'].present?
        u = URI.parse(ENV['DYNAMODB_HOST'])
        return ENV['DYNAMODB_HOST'] if %w{http https}.include?(u.scheme)

        return "http://#{ ENV['DYNAMODB_HOST'] }"
      end

      if ENV['DYNAMODB_SERVICE_SERVICE_HOST'].present? && ENV['DYNAMODB_SERVICE_SERVICE_PORT'].present?
        return "http://#{ENV['DYNAMODB_SERVICE_SERVICE_HOST']}:#{ENV['DYNAMODB_SERVICE_SERVICE_PORT']}"
      end

      raise 'Missing host for Dynamo'
    end

    def client
      @client ||= Aws::DynamoDB::Client.new(
        endpoint: end_point,
        region: 'us-east-1',
        credentials: Aws::Credentials.new('XXX', 'XXX')
      )
    end
  end

  class Table
    class << self
        # Example: Dynamo::Table.list
      def list
        Dynamo.client.list_tables
      end
=begin
      Example:
      Dynamo::Table.create(
        table_name: 'test',
        key_schema: [{
          attribute_name: 'year',
          key_type: 'HASH'  # Partition key.
        }, {
          attribute_name: 'title',
          key_type: 'RANGE' # Sort key.
        }],
        attribute_definitions: [{
          attribute_name: 'year',
          attribute_type: 'N'
        }, {
          attribute_name: 'title',
          attribute_type: 'S'
        }],
        provisioned_throughput: {
          read_capacity_units: 10,
          write_capacity_units: 10
        }
      )
=end
      def create(table_name:, key_schema:, attribute_definitions:, **options)
        Dynamo.client.create_table({
          table_name: table_name,
          key_schema: key_schema,
          attribute_definitions: attribute_definitions,
          **options
        })
      end
    end

    attr_accessor :table_name

    def initialize(table_name)
      @table_name = table_name
    end

=begin
    Example:
    Dynamo::Table.new('test').put({
      "year": 1985,
      "title": "The Big Movie",
    })
=end
    def put(item, **options)
      Dynamo.client.put_item({
        table_name: table_name,
        item: item,
        **options
      })
    end

=begin
    Example:
    Dynamo::Table.new('test').get_item({
      "year": 1985,
      "title": "The Big Movie",
    })
=end
# Dynamo.client.get_item({ table_name: 'test', key: { "year": 1985, "title": "The Big Movie" } })
    def get_item(key)
      Dynamo.client.get_item({
        table_name: table_name,
        key: key
      })
    end

=begin
    Example:
    Dynamo::Table.new('test').delete_item({
      "year": 1985,
      "title": "The Big Movie",
    })
=end
    def delete_item(key)
      Dynamo.client.delete_item(table_name: table_name, key: key)
    end
  end
end
