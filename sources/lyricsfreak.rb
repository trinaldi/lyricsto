# frozen_string_literal: true

require_relative '../crawler'
require_relative './source'

module Sources
  class LyricsFreak
    include Crawler
    include Source

    HOST = 'https://www.lyricsfreak.com'

    attr_reader :artist, :song

    def initialize(artist:, song:)
      @artist = artist
      @song = song
    end

    def fetch_lyrics_url
      search_url = "#{HOST}/search.php"
      html = fetch_response(url: search_url, type: :html, config:
                            { headers: spoof_user_agent,
                              query: { q: "#{artist} #{song}" } })
      check_content(html.css('.song'))
      lyrics_path = html.css('.song').attr('href').value
      "#{HOST}#{lyrics_path}"
    end

    def fetch_lyrics
      url = fetch_lyrics_url
      html = fetch_response(url: url, type: :html, config: { headers: spoof_user_agent })
      words = check_content(html.css('div[data-container-id="lyrics"]').text.strip!)
      display_lyrics(words)
    end
  end
end
