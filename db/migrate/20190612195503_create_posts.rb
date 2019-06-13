class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :caption
      t.integer :status
      t.integer :category
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
