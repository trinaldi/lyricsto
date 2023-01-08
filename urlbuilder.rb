require './sources/azlyrics'

# frozen_string_literal: true

class URLBuilder
  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def host
    'https://www.azlyrics.com/lyrics'
  end

  def urlize(text)
    text.downcase.split.reject(&:empty?).join('')
  end

  def build_artist_song(artist, song)
    artist = urlize(artist)
    song = urlize(song)
    "#{artist}/#{song}"
  end

  def full_url(artist, song)
    artist_song = build_artist_song(artist, song)
    "#{host}/#{artist_song}.html"
  end

  def broadcast
    url = full_url(artist, song)
    AZLyrics.new(artist: artist, song: song, url: url).subscribe
  end
end
