require_relative 'genre'
require_relative 'review'
require 'pry'

class Movie < ActiveRecord::Base
  has_many :reviews
  validates :name, uniqueness: true

  def self.default
    Movie.find_or_create_by(name: "Unknown_Movie", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
  end

  def self.find_similar name
    similar = Movie.where("name LIKE '%#{name}%'")
    similar_titles = []
    similar.each do |movie|
      similar_titles << movie["name"]
    end
    similar_titles
  end
end