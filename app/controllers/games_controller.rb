require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    if english_word?(params[:attempt])
      if included?(params[:attempt].upcase, params[:grid])
        @result = "Nice!"
      else
        @result = "Only use the given letters!"
      end
    else
      @result = "Doesn't exist!"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
