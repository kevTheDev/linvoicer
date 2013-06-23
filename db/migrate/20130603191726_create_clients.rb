class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.float  :hourly_rate
      t.timestamps
    end
  end
end
