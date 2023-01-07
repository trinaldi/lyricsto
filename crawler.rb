require './urlbuilder'
require 'nokogiri'
require 'open-uri'

module Crawler
  include URLBuilder

  def response(artist, song)
    begin
      Nokogiri::HTML5(URI.open(full_url(artist, song)))
    rescue
      puts 'Ops, não encontrei :('
      exit 1
    end
  end

  def split_newline(text)
    text.split("\n")
  end

  def matchify(css, match)
    css.text.match(/#{match}/i)
  end
end
