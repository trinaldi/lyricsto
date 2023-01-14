# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

module Crawler
  def self.included(base)
    base.extend(ClassMethods)
  end

  def response(url:, config: {})
    response(url: url, config: config)
  end

  module ClassMethods
    def response(url:, config: {})
      response = HTTParty.get(url, {
                                headers: config[:headers]
                              })
      body = response.body
      parse_response_type(body, config[:type])
    rescue StandardError
      puts 'Oops! I can\'t find this one :('
      exit 1
    end

    def parse_response_type(body:, response_type:)
      case response_type
      when :html
        Nokogiri::HTML5(body)
      when :json
        JSON.parse(body)
      end
    end
  end
end
