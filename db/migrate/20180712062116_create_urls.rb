class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.references :user, index: true
      t.datetime :expired_at
      t.string :title, null: false, default: ''
      t.text :origin
      t.string :shortened, null: false, default: ''
      t.timestamps
    end
    add_index :urls, :shortened, unique: true
  end  
end
