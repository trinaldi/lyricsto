# frozen_string_literal: true

module SourceMatchers
  def contain_content_matching(pattern)
    include(match(/#{pattern}/i))
  end

  def puts_to_stdout(text)
    output(text).to_stdout
  end
end
