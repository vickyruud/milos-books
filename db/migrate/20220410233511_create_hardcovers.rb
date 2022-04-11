class CreateHardcovers < ActiveRecord::Migration[7.0]
  def change
    create_table :hardcovers do |t|
      t.string :display_name
      t.string :list_name
      t.string :list_name_encoded
      t.datetime :newest_published_date
      t.datetime :oldest_published_date
      t.string :updated

      t.timestamps
    end
  end
end
