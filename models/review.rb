class Review
  attr_accessor :review, :name
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def save
    db = Environment.database_connection

    if id
      db.execute "UPDATE movies SET title = '#{name}', year = #{year}, length = #{length}, budget = #{budget}, mpaa = '#{mpaa}', genreID = #{genreID} WHERE CAST(movieID AS INTEGER)=#{id}"
      success = true
    else
      movie = Movie.find(name)
      movieID = movie.id
      review_row = db.execute "SELECT * FROM reviews JOIN movies ON reviews.movieID = CAST(movies.movieID AS INTEGER) WHERE CAST(movies.title AS varchar)='#{movie.name}'"

      totalReviewIDs = db.execute "SELECT COUNT(*) FROM reviews"
      @id ||= totalReviewIDs[0][0] + 1
      db.execute "INSERT INTO reviews(reviewID,movieID,review) VALUES (#{@id},'#{movieID}',#{review})"
    end
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :review].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end

end