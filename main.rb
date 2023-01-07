require 'open-uri'
require 'nokogiri'
require './urlbuilder'

include URLBuilder

class LyricsTo
  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def artist_name
    matchify(html.css('b'), artist)
  end

  def song_title
    matchify(html.css('b'), song)
  end

  def lyrics
    words = get_lyrics
    sentenceize(words).each { |word| puts word }
  end

  private

  def url
    URLBuilder.full_url(artist, song)
  end

  def get_lyrics
    html.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text
  end

  def sentenceize(text)
    text.split("\n")
  end


  def matchify(css, match)
    css.text.match(/#{match}/i)
  end


  def html
    Nokogiri::HTML5(URI.open(url))
  end
end

artist = ARGV[0]
song = ARGV[1]
l = LyricsTo.new(artist: artist, song: song)
l.artist_name
l.song_title
l.lyrics
