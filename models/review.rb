require 'pry'

class Review < ActiveRecord::Base
  belongs_to :movie
end