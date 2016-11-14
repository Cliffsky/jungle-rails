class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :rating
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps null: false
    end
  end
end
