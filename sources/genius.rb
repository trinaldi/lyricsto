# frozen_string_literal: true

require_relative '../crawler'
require_relative './source'

module Sources
  class Genius < Source
    include Crawler

    HOST = 'https://genius.com/api/search/multi'

    attr_reader :artist, :song

    def initialize(artist:, song:)
      @artist = artist
      @song = song
    end

    def fetch_song_url
      json = fetch_response(url: HOST, type: :json,
                            config: { query: { q: "#{artist} #{song}", per_page: 1 } })
      description_url = song_url(json)
      description(description_url)
    end

    def description(description_url)
      html = fetch_response(url: description_url, type: :html)
      words = html.css('div[class*="ExpandableContent__Content"] p').text
      check_content(words)
      display_description(words)
    end

    private

    def draw_title
      puts ''
      puts 'Song description by Genius:'
      puts ''
    end

    def display_description(words)
      draw_title
      puts text_splitter(words)
    end

    def song_url(json)
      json.dig('response', 'sections', 0, 'hits', 0, 'result', 'url')
    end
  end
end
