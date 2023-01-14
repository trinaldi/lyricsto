# frozen_string_literal: true

require_relative '../crawler'
require 'byebug'

module Sources
  class Genius
    include Crawler

    HOST = 'https://genius.com/api/search/multi?per_page=1'

    attr_reader :artist, :song

    def initialize(artist:, song:)
      @artist = artist
      @song = song
    end

    def fetch_song_url
      url = full_url(artist, song)
      json = fetch_response(url: url, type: :json)
      description_url = song_url(json)
      description(description_url)
    end

    def description(description_url)
      html = fetch_response(url: description_url, type: :html)
      words = html.css('div[class*="ExpandableContent__Content"] p').text
      puts "\nSong Description by Genius"
      display(words)
    end

    private

    def song_url(json)
      json.dig('response', 'sections', 0, 'hits', 0, 'result', 'url')
    end

    def split_newline(text)
      text.split("\n")
    end

    def full_url(artist, song)
      query = "#{artist} #{song}"
      "#{HOST}&q=#{query}"
    end

    def display(words)
      split_newline(words).each { |word| puts word }
    end
  end
end
