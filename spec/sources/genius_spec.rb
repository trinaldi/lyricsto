# frozen_string_literal: true

require 'spec_helper'
require_relative '../../crawler'
require_relative '../../sources/genius'

describe Sources::Genius do
  describe '#fetch_song_url' do
    context 'when an artist and song are given' do
      let(:response) { described_class.new(artist: 'Beatles', song: 'Help') }
      let(:request) do
        stub_request(:get, 'https://genius.com/The-beatles-help-lyrics')
          .to_return(status: 200, body: read_file('genius_description.html'), headers: {})
      end
      let(:api_request) do
        stub_request(:get, 'https://genius.com/api/search/multi?per_page=1&q=Beatles%20Help')
          .to_return(status: 200, body: read_file('genius_api_response.json'), headers: {})
      end

      before do
        api_request
        request
        response
      end

      it 'returns the song url' do
        expect { response.fetch_song_url }.to puts_to_stdout(/Help!/i)
      end
    end
  end
end
