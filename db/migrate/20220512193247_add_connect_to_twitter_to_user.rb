class AddConnectToTwitterToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :connect_to_twitter, :boolean, default: true
  end
end
