class Genre
  @@genre_order = {"action" => 1, "animation" => 2, "comedy" => 4, "drama" => 8, "documentary" => 16, "romance" => 32, "short" => 64 }
  attr_reader :id
  attr_accessor :name

  def self.default
    @@default ||= Genre.new("action")
  end

  def initialize(name)
    self.name = name
  end

  def parse_id
    all_genres = @name.split("-")
    sum = 0
    all_genres.each do |genre| 
      sum += @@genre_order[genre.downcase]
    end
    sum
  end

  def self.parse_name id
    int_id = id.to_i
    return if int_id > 127
    new_id = int_id.to_s(2)
    new_id.reverse!
  
    genre_name = []
    i = 0
    new_id.each_char do |value|
      genre_name << @@genre_order.keys[i] if value.to_i == 1
      i += 1
    end
    genre_label = genre_name.join("-")
  end
end