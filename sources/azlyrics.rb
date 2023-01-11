# frozen_string_literal: true

require_relative '../crawler'

class AZLyrics
  attr_reader :html

  def initialize(html:)
    @html = html
  end

  def parse_lyrics
    html.xpath('//div[@class="ringtone"]//following-sibling::div[1]').text
  end

  def display_lyrics
    words = parse_lyrics
    split_newline(words).each { |word| puts word }
  end

  def subscribe
    parse_lyrics
    display_lyrics
  end

  private

  def split_newline(text)
    text.split("\n")
  end
end
