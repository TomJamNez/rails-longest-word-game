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
    is_english = dictionary_hash(params[:word])["found"]

    puts "console log is_english = #{is_english}"
    array_letters = params[:letters].split(" ")
    # puts params[:letters]
    # p array_guess
    attempt_array = params[:word].upcase.split("")
    valid_word = grid_check(attempt_array, array_letters)
    puts "console log valid_word = #{valid_word}"
    @result = {}
    @result = result_builder(is_english, valid_word, params[:word], params[:letters])
    puts "console log result #{@result[:message]}"

  end





private

def dictionary_hash(attempt)
  url = "https://dictionary.lewagon.com/#{attempt}"
  url_serialized = URI.parse(url).read
  dictionary_result = JSON.parse(url_serialized)
end

def grid_check(attempt_array, array_letters)

  result = false

  attempt_array.each do |letter|
    if attempt_array.count(letter) > array_letters.count(letter)
     result = false
     break
    elsif array_letters.count(letter) == 0
      result = false
      break
    else
      result = true
    end
  end
  return result
end

def result_builder(is_english, valid_word, word, letters)
  if is_english == false
    result = {
      message: "Sorry but <strong>#{word}</strong> does not seem to be a valid English Word"
    }
  elsif valid_word == false
    result = {
      message: "Sorry but <strong>#{word}</strong> can't be built out of #{letters}"
    }
  else
    result = {
      message: "<strong>Congratulations!</strong> #{word} is a valid English word! #{letters}"
    }
  end
result

end
end
