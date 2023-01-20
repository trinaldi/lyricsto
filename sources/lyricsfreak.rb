# frozen_string_literal: true

require_relative '../crawler'

module Sources
  class LyricsFreak
    include Crawler

    HOST = 'https://www.lyricsfreak.com'

    attr_reader :artist, :song

    def initialize(artist:, song:)
      @artist = artist
      @song = song
    end

    def fetch_lyrics_url
      url = full_url(artist, song)
      html = fetch_response(url: url, type: :html, config: { headers: spoof_user_agent })

      lyrics_path = html.css('.song').attr('href').value
      "#{HOST}#{lyrics_path}"
    end

    def fetch_lyrics
      url = fetch_lyrics_url
      html = fetch_response(url: url, type: :html, config: { headers: spoof_user_agent })
      words = html.css('div[data-container-id="lyrics"]').text.strip!
      display_lyrics(words)
    end

    private

    def full_url(artist, song)
      "#{HOST}/search.php?q=#{artist} #{song}"
    end

    def spoof_user_agent
      {
        'User-Agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1)' \
        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
      }
    end

    def split_newline(text)
      text.split("\n")
    end

    def display_lyrics(words)
      split_newline(words).each { |word| puts word }
    end
  end
end
