require 'pry'
require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    source = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << source[rand(source.size)].to_s }
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    hash = open(url).read
    if hash.include?('true')
      @exists = "#{params[:word].upcase} is a real English word wow bro wow"
    elsif hash.include?('false')
      @exists = "#{params[:word].upcase} doesn't exist bro..."
    end
  end

    @word = params[:word].upcase.split("").sort
    @table = params[:table].split("").sort
    word_array = @word.uniq
    table_array = @table.uniq
    word_string = word_array.join
    table_string = table_array.join
    if table_string.include?(word_string)
      @legit = "Your word is valid!!"
    else
      @legit = "Sorry but #{word_string} can't be built out of #{table_string}"
    end
  end
end
