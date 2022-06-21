class ChangeNameFieldToTwitterName < ActiveRecord::Migration[7.0]
  def up
    rename_column :users, :name, :twitter_name
  end

  def down
    rename_column :users, :twitter_name, :name
  end
end
