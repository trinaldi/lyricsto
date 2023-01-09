# frozen_string_literal: true

require './crawler'

class AZLyrics
  attr_reader :html

  def initialize(html:)
    @html = html
  end

  def subscribe
    print
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
    lyrics
  end

  private

  def split_newline(text)
    text.split("\n")
  end

  def matchify(css, match)
    css.text.match(/#{match}/i)
  end
end
