# frozen_string_literal: true

require './menu'
require './urlbuilder'

class LyricsTo
  attr_reader :artist, :song

  def initialize(artist:, song:)
    @artist = artist
    @song = song
  end

  def call
    URLBuilder.new(artist: artist, song: song).broadcast
  end
end

options = Menu.new(artist: ARGV[0], song: ARGV[1]).create
LyricsTo.new(artist: options['a'], song: options['s']).call
