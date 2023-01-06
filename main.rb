require 'open-uri'
require 'nokogiri'
require 'byebug'

module URLBuilder
  def self.urlize(text)
    text.downcase.split.reject(&:empty?).join('')
  end

  def self.build_url(band, song)
    band = urlize(band)
    song = urlize(song)
    "#{band}/#{song}"
    byebug
  end
end

band = "Neutral Milk Hotel"
song = 'In The Aeroplane Over The Sea'
band_url = URLBuilder.build_url(band, song)
doc = Nokogiri::HTML5(URI.open('https://www.azlyrics.com/lyrics/neutralmilkhotel/intheaeroplaneoverthesea.html'))
title = doc.css('b')
puts title.text.match(/#{band}/i)
puts title.text.match(/#{song}/i)

