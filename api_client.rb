# frozen_string_literal: true

# Module that wraps Faraday and calls the Pinpoint API
module API
  require 'faraday'
  require 'pry'

  # Class that wraps the Faraday connection and makes the API calls
  class Client
    def initialize(sub_domain, api_key)
      @connection = Faraday.new(url: "https://#{sub_domain}.pinpointhq.com/api/v1/",
                                headers: { 'X-API-KEY' => api_key.to_s,
                                           'Accept' => 'application/vnd.api+json' }) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def get(path, params = {})
      response = @connection.get do |req|
        req.url path
        # binding.pry
        req.params = params
      end
      JSON.parse(response.body)
    end

    def post(path, params = {})
      response = @connection.post do |req|
        req.url path
        req.body = params
      end
      JSON.parse(response.body)
    end
  end
end
