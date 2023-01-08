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
    end
  rescue Slop::MissingRequiredOption
    puts 'Please enter an artist AND a song'
    exit 1
  rescue Slop::UnknownOption => e
    puts e.to_s.capitalize
    exit 1
  end
end
