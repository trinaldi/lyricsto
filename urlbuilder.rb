# frozen_string_literal: true

require_relative 'sources/azlyrics'
require_relative 'crawler'

# frozen_string_literal: true

class URLBuilder
  HOST = 'https://www.azlyrics.com/lyrics'.freeze

  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def full_url(artist, song)
    artist_song = build_artist_song(artist, song)
    "#{HOST}/#{artist_song}.html"
  end

  def broadcast
    url = full_url(artist, song)
    html = Crawler.new.response(url: url)
    AZLyrics.new(html: html).subscribe
  end

  private

  def build_artist_song(artist, song)
    artist = arg_to_path(artist)
    song = arg_to_path(song)
    "#{artist}/#{song}"
  end

  def arg_to_path(text)
    text.downcase.split.reject(&:empty?).join
  end

end
