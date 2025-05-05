require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []

    9.times do
      letter = (65 + (rand(26))).chr
      @letters << letter
    end

  end

  def score
    # @word = params[:word]
    not_english = dictionary_hash(params[:word])["found"] == false

    puts "console log not_english = #{not_english}"
    array_guess = params[:letters].split(" ")
    # puts params[:letters]
    # p array_guess
  end
private

def dictionary_hash(attempt)
  url = "https://dictionary.lewagon.com/#{attempt}"
  url_serialized = URI.parse(url).read
  dictionary_result = JSON.parse(url_serialized)
end


end
