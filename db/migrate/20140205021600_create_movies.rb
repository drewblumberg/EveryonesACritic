class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies, :id => false do |t|
      t.integer :movieID, :null => false
      t.string :title
      t.integer :year
      t.integer :length
      t.integer :budget
      t.decimal :aggregateRating
      t.integer :totalReviews
      t.integer :year
      t.string :mpaa
      t.integer :genreID
    end
  end
end