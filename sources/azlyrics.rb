require './crawler'

class AZLyrics
  include Crawler
  attr_reader :artist, :song, :url

  def initialize(artist:, song:, url:)
    @artist = artist
    @song = song
    @url = url
  end

  def subscribe
    print    
  end

  def html
    response(url)
  end

  def artist_name
    matchify(html.css('b'), artist)
  end

  def fetch_lyrics
    html.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text
  end

  def song_title
    matchify(html.css('b'), song)
  end

  def lyrics
    words = fetch_lyrics
    split_newline(words).each { |word| puts word }
  end

  def print
    puts "#{song_title} by #{artist_name}"
    lyrics
  end

  private

  def split_newline(text)
    text.split("\n")
  end

  def matchify(css, match)
    css.text.match(/#{match}/i)
  end
end
