class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.belongs_to :metric, index: true
      t.float :value

      t.timestamps
    end
  end
end
