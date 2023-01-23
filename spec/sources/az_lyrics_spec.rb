# frozen_string_literal: true

require 'spec_helper'
require_relative '../../crawler'
require_relative '../../sources/azlyrics'

describe Sources::AZLyrics do
  describe '#fetch_lyrics' do
    context 'when an artist and song are given' do
      let(:beatles) { 'Beatles' }
      let(:help) { 'Help' }
      let(:azlyrics_url) { 'https://www.azlyrics.com/lyrics/beatles/help.html' }
      let(:response) { described_class.new(artist: beatles, song: help).fetch_lyrics }
      let(:request) do
        stub_request(:get, azlyrics_url)
          .to_return(status: 200, body: read_file('beatles_help.html'), headers: {})
      end

      before do
        request
        response
      end

      it 'returns the correct lyrics' do
        expect(response).to contain_content_matching('Help me if you can, I\'m feeling down')
      end
    end
  end
end
