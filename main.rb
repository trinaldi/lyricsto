# frozen_string_literal: true

require 'byebug'
require './crawler'
require './menu'
require 'slop'

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
end

options = Menu.new(artist: ARGV[0], song: ARGV[1]).create
LyricsTo.new(artist: options['a'], song: options['s']).print
