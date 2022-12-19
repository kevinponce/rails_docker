class AddCountToExamples < ActiveRecord::Migration[7.0]
  def change
    add_column :examples, :count, :integer
  end
end
