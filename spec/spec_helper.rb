# frozen_string_literal: true

require 'webmock/rspec'
require 'integration/crawler_spec'
require 'integration/sources/source_spec'

WebMock.disable_net_connect!(allow_localhost: true)

RSPEC_ROOT = File.dirname __FILE__

def read_file(file_name)
  File.open("#{RSPEC_ROOT}/fixtures/#{file_name}")
end

RSpec.configure do |c|
  c.silence_filter_announcements = true
  c.include CrawlerMatchers
  c.include SourceMatchers
  # c.before { allow($stdout).to receive(:puts) }
end
