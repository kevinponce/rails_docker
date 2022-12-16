class DynamoController < ApplicationController
  before_action :create_dynamo_table!

  def index
    @page_count = current_count('dynamo', 'index') + 1
    save_count!('dynamo', 'index', @page_count)
  end

  private

  def table_name
    'page_count'
  end

  def create_dynamo_table!
    return if Dynamo::Table.list.table_names.include? table_name

    Dynamo::Table.create(
      table_name: table_name,
      key_schema: [{
        attribute_name: 'controller',
        key_type: 'HASH'  # Partition key.
      }, {
        attribute_name: 'method',
        key_type: 'RANGE' # Sort key.
      }],
      attribute_definitions: [{
        attribute_name: 'controller',
        attribute_type: 'S'
      }, {
        attribute_name: 'method',
        attribute_type: 'S'
      }],
      provisioned_throughput: {
        read_capacity_units: 10,
        write_capacity_units: 10
      }
    )
  end

  def test(controller, method)
    Dynamo::Table.new(table_name).get_item({
      "controller": controller,
      "method": method,
    }).item
  end

  def current_count(controller, method)
    item = Dynamo::Table.new(table_name).get_item({
      "controller": controller,
      "method": method,
    }).item

    return 0 unless item

    item['count']&.to_i || 0
  end

  def save_count!(controller, method, count)
    Dynamo::Table.new(table_name).put({
      "controller": controller,
      "method": method,
      "count": count,
    })
  end
end