# frozen_string_literal: true

module Sources
  module Source
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

    def text_splitter(text, line_size = 80)
      puts text.gsub(/(?:.{1,#{line_size}}|\S+)\K(?:$|\s)/, "\n")
    end

    def display_lyrics(words)
      split_newline(words).each { |word| puts word }
    end
  end
end
