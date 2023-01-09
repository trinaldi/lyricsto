# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Crawler
  def response(url:)
    uri = URI.parse(url)
    Nokogiri::HTML5(uri.open)
  rescue StandardError
    puts 'Oops! I can\'t find this one :('
    exit 1
  end
end
