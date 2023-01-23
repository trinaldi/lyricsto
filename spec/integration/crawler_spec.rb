# frozen_string_literal: true

module CrawlerMatchers
  def have_content_with_text(text)
    eq(text)
  end

  def be_empty(text)
    eq(text.empty?)
  end
end
