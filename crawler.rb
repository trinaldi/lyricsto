# frozen_string_literal: true

require './urlbuilder'
require 'nokogiri'
require 'open-uri'

module Crawler
  include URLBuilder

  def response(artist, song)
    uri = URI.parse(full_url(artist, song))
    Nokogiri::HTML5(uri.open)
  rescue StandardError
    puts 'Ops, não encontrei :('
    exit 1
  end

  def split_newline(text)
    text.split("\n")
  end

  def matchify(css, match)
    css.text.match(/#{match}/i)
  end
end
