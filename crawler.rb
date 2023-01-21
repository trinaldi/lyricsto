# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

module Crawler
  class CrawlerError < StandardError; end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def check_content(content)
    if content.empty? || content.nil?
      puts 'Could not find anything :('
      exit 0
    end

    content
  end

  def fetch_response(url:, type:, config: {})
    self.class.request(url: url, config: config, type: type)
  end

  module ClassMethods
    def request(url:, type:, config: {})
      response = HTTParty.get(url, { headers: config[:headers], query: config[:query] })
      body = response.body
      parse_response_type(body: body, response_type: type)
    rescue StandardError; oops
    end

    def parse_response_type(body:, response_type:)
      case response_type
      when :html
        Nokogiri::HTML5(body)
      when :json
        JSON.parse(body)
      end
    end

    def oops
      puts 'Oops, something went wrong =/'
      exit 1
    end
  end
end
