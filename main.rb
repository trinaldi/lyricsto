require 'byebug'
require './crawler'

class LyricsTo
  include Crawler

  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def html
    response(artist, song)
  end

  def artist_name
    matchify(html.css('b'), artist)
  end

  def get_lyrics
    html.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text
  end

  def song_title
    matchify(html.css('b'), song)
  end

  def lyrics
    words = get_lyrics
    split_newline(words).each { |word| puts word }
  end
end

artist = ARGV[0]
song = ARGV[1]
exit 1 unless artist || song

lyricsto = LyricsTo.new(artist: artist, song: song)

lyricsto.artist_name
lyricsto.song_title
lyricsto.lyrics
