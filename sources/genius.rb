# frozen_string_literal: true

require_relative '../crawler'

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

    def full_url(artist, song)
      query = "#{artist} #{song}"
      "#{HOST}&q=#{query}"
    end

    def text_splitter(text, line_size = 80)
      text.gsub(/(?:.{1,#{line_size}}|\S+)\K(?:$|\s)/, "\n")
    end
  end
end
