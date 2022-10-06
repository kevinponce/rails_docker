class CreateExample < ActiveRecord::Migration[6.1]
  def change
    create_table :examples do |t|
      t.string :name

      t.timestamps
    end
  end
end
