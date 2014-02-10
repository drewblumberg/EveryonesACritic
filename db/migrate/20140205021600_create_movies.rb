class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :year
      t.integer :length
      t.integer :budget
      t.decimal :aggregateRating
      t.integer :totalReviews
      t.integer :year
      t.string :mpaa
      t.integer :genre_id
    end
  end
end