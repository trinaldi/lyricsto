# frozen_string_literal: true

require 'byebug'
require_relative '../crawler'

module Sources
  class AZLyrics
    include Crawler

    HOST = 'https://www.azlyrics.com/lyrics'

    attr_reader :artist, :song

    def initialize(artist:, song:)
      @artist = artist
      @song = song
    end

    def fetch_lyrics
      url = full_url(artist, song)
      html = fetch_response(url: url, type: :html)
      words = parse_lyrics(html)
      display_lyrics(words)
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

    def split_newline(text)
      text.split("\n")
    end

    def full_url(artist, song)
      artist_song = build_artist_song(artist, song)
      "#{HOST}/#{artist_song}.html"
    end

    def parse_lyrics(body)
      check_content(body.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text)
    end

    def display_lyrics(words)
      split_newline(words).each { |word| puts word }
    end
  end
end
