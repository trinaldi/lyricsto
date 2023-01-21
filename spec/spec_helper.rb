# frozen_string_literal: true

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSPEC_ROOT = File.dirname __FILE__

def read_file(file_name)
  File.open("#{RSPEC_ROOT}/fixtures/#{file_name}")
end

RSpec.configure do |c|
  c.silence_filter_announcements = true
  c.before { allow($stdout).to receive(:puts) }
end
