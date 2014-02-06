class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres, :id => false do |t|
      t.integer :genreID, :null => false
      t.integer :action
      t.integer :animation
      t.integer :comedy
      t.integer :drama
      t.integer :documentary
      t.integer :romance
      t.integer :short
    end
  end
end