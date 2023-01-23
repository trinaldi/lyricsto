# frozen_string_literal: true

require 'spec_helper'
require_relative '../../crawler'
require_relative '../../sources/lyricsfreak'

describe Sources::LyricsFreak do
  describe '#fetch_song_url' do
    context 'when an artist and song are given' do
      let(:response) { described_class.new(artist: 'Beatles', song: 'Help') }
      let(:request) do
        stub_request(:get, 'https://www.lyricsfreak.com/search.php?q=Beatles%20Help')
          .to_return(status: 200, body: read_file('lyricsfreak_search.html'), headers: {})
      end
      let(:api_request) do
        stub_request(:get, 'https://www.lyricsfreak.com/l/loukass/beatles+help_20570316.html')
          .to_return(status: 200, body: read_file('lyricsfreak_lyrics.html'), headers: {})
      end

      before do
        api_request
        request
        response
      end

      it 'returns the song url' do
        expect { response.fetch_lyrics }.to puts_to_stdout(/Help!/i)
      end
    end
  end
end
