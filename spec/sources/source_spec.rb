# frozen_string_literal: true

require 'spec_helper'
require_relative '../../sources/source'

describe Sources::Source do
  let(:dummy) { Class.new.extend(described_class) }

  specify '#spoof_user_agent' do
    expect(dummy.spoof_user_agent).to contain_content_matching('User-Agent')
  end

  describe '#split_newline' do
    context 'when given a string with the \n char' do
      let(:text) { "Hello\nWorld" }
      let(:text_array) { %w[Hello World] }

      it 'will break it into an array' do
        expect(dummy.split_newline(text)).to eq(text_array)
      end
    end
  end

  describe '#text_splitter' do
    context 'when given a string longer than the preset line_size argument' do
      let(:text) { 'I am the Walrus' }
      let(:line_size) { text.length / 2 }

      it 'will break it in line_number chars each line' do
        expect { dummy.text_splitter(text, line_size) }.to puts_to_stdout("I am\nthe\nWalrus\n")
      end
    end
  end

  describe '#display_lyrics' do
    context 'when given an array of string' do
      let(:string_array) { 'Hello Goodbye' }
      let(:text) { "Hello Goodbye\n" }

      it 'will output each item to stdout' do
        expect { dummy.display_lyrics(string_array) }.to puts_to_stdout(text)
      end
    end
  end
end
