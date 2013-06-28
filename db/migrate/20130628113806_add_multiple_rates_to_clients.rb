class AddMultipleRatesToClients < ActiveRecord::Migration
  def change
    add_column :clients, :supervision_rate, :float, default: 0
    add_column :clients, :training_rate,    :float, default: 0
  end
end
