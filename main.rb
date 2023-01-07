require 'open-uri'
require 'nokogiri'
require 'byebug'
require './urlbuilder'

include URLBuilder

class LyricsTo
  attr_reader :band, :song

  def initialize(band:, song:)
    @band = band
    @song = song
  end

  def url
    URLBuilder.full_url(@band, @song)
  end

  def html
   Nokogiri::HTML5(URI.open(url))
  end

  def matchify(css, match)
    css.text.match(/#{match}/i)
  end

  def band_name
    band_name = html.css('b')
    matchify(band_name, band)
  end

  def song_title
    song_title = html.css('b')
    matchify(song_title, song)
  end

  def lyrics
    html.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text
  end

  def display_lyrics
    sentenceize(lyrics).each { |l| puts l }
  end

  def sentenceize(text)
    text.split("\n")
  end
end

band = ARGV[0]
song = ARGV[1]
l = LyricsTo.new(band: band, song: song)
l.band_name
l.song_title
l.display_lyrics
