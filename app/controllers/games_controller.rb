require 'open-uri'
require 'json'
require 'byebug'


class GamesController < ApplicationController
  def new 
    @letters = (0..9).map{("A".."Z").to_a.sample}
  end

  def score
    @results = letter_include? && valid?
    
  end

  def letter_include?
    return params["input"].chars.all? do |letter| 
      params["input"].count(letter) <= params["word"].downcase.count(letter)
    end
  end
  
  def valid?
    url = "https://wagon-dictionary.herokuapp.com/#{params["input"]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    return user["found"]
  end
  
end
