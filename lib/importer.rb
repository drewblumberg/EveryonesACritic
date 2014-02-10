require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_product(row_hash)
    end
  end

  def self.import_product(row_hash)
    year = row_hash["year"].to_i if row_hash["year"]
    length = row_hash["length"].to_i if row_hash["length"]
    budget = row_hash["budget"].to_i if row_hash["budget"]
    aggregateRating = row_hash["aggregateRating"].to_f if row_hash["aggregateRating"]
    totalReviews = row_hash["totalReviews"].to_i if row_hash["totalReviews"]
    movie = Movie.create(
      name: row_hash["name"],
      year: row_hash["year"].to_i,
      length: row_hash["length"].to_i,
      budget: row_hash["budget"].to_i,
      aggregateRating: row_hash["aggregateRating"].to_f,
      totalReviews: row_hash["totalReviews"].to_i,
      mpaa: row_hash["mpaa"],
      genre_id: row_hash["genre_id"],
    )
  end
end