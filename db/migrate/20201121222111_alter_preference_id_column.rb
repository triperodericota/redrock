class AlterPreferenceIdColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :preference_id, :string, null: false
  end
end
