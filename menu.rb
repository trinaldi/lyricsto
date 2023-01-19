# frozen_string_literal: true

require 'slop'

class Menu
  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def create
    Slop.parse do |o|
      o.string '-a', '--artist', 'Artist/Band name', required: true
      o.string '-s', '--song', 'Song title', required: true
      o.boolean '-d', '--description', "Genius' song description", default: false
    end
  rescue Slop::MissingRequiredOption; no_artist_or_song
  rescue Slop::UnknownOption => e; error(e)
  end

  def error(error)
    puts error.to_s.capitalize
    exit 1
  end

  def no_artist_or_song
    puts 'Please enter an artist AND a song'
    exit 1
  end
end
