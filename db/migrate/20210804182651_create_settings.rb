class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :sweeping, default: false
      t.integer :time_threshold, default: 365

      t.timestamps
    end
  end
end
