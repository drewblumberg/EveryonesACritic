class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews, :id => false do |t|
      t.integer :reviewID, :null => false
      t.integer :movieID
      t.decimal :review
    end
  end
end