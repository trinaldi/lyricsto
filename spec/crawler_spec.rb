# frozen_string_literal: true

require 'spec_helper'
require_relative '../crawler'

class Dummy
  include Crawler
end

RSpec.describe Crawler do
  describe '#check_content' do
    context 'when context is not empty' do
      let(:content) { 'not empty' }

      it 'returns the contents' do
        expect(Dummy.new.check_content(content)).to eq(content)
      end
    end

    context 'when content is empty or nil' do
      let(:content) { ['', nil].sample }

      it 'force exit the application' do
        expect { Dummy.new.check_content(content) }.to raise_error(SystemExit)
      end
    end
  end

  describe '#fetch_response' do
    context 'when given a valid url' do
      let(:url) { 'https://trinaldi.github.io' }
      let(:type) { :html }
      let(:response) { Dummy.new.fetch_response(url: url, type: type) }
      let(:request) do
        stub_request(:get, url)
          .to_return(status: 200, body: '<p>Hi</p>', headers: {})
      end

      before do
        request
        response
      end

      it 'returns an html payload' do
        expect(response.css('p').text).to eq('Hi')
      end
    end

    context 'when given a valid json endpoint' do
      let(:url) { 'https://trinaldi.github.io/json' }
      let(:type) { :json }
      let(:response) { Dummy.new.fetch_response(url: url, type: type) }
      let(:request) do
        stub_request(:get, url)
          .to_return(status: 200, body: { greeting: 'Hi' }.to_json, headers: {})
      end

      before do
        request
        response
      end

      it 'returns a json payload' do
        expect(response['greeting']).to eq('Hi')
      end
    end
  end
end
