require 'rubygems'
require 'json'
require 'rest-client'

class StreamsController < ApplicationController
  @@wsc_api_key = "cVTeRj8SHpZ2rMmik9lkSVcgDf4xar8myyrr2zX5B11CMiP0brfQK7yBh78Z3423"
  @@wsc_access_key = "ha5zig1TQX2VSlWrFUzFBZLGOT6tb04GOHZiuYuHkIeqzeBCkYW5HOc75VVG325e"
  def new

  end
  def index
    RestClient.get(
      'https://api-sandbox.cloud.wowza.com/api/v1/live_streams/' + params[:id],
      :content_type => :json,
      :accept => :json,
      :'wsc-api-key' => @@wsc_api_key,
      :'wsc-access-key' => @@wsc_access_key
    ) { |response, request, result|
      case response.code
      when 301, 302, 307
        response.follow_redirection
      else
        data = JSON.parse(response)['live_stream']['source_connection_information']
        url = JSON.parse(response)['live_stream']['hosted_page_url']
        @stream = {
          id: JSON.parse(response)['live_stream']['id'],
          primary_server: data['primary_server'],
          host_port: data['host_port'],
          stream_name: data['stream_name'],
          hosted_page: url
        }
        render 'stream'
      end
    }
  end

  def create
    data = {live_stream: {
        name: params[:streams][:stream_name],
        transcoder_type: params[:streams][:transcoder_type],
        billing_mode: params[:streams][:billing_mode],
        broadcast_location: params[:streams][:broadcast_location],
        encoder: params[:streams][:encoder],
        delivery_method: params[:streams][:delivery_method],
        aspect_ratio_width: params[:streams][:aspect_ratio_width],
        aspect_ratio_height: params[:streams][:aspect_ratio_height],
        disable_authentication: true,
        hosted_page: true,
        hosted_page_description: params[:streams][:stream_name],
        hosted_page_title: params[:streams][:stream_name],
      }}
    RestClient.post(
      'https://api-sandbox.cloud.wowza.com/api/v1/live_streams',
      data.to_json,
      :content_type => :json,
      :accept => :json,
      :'wsc-api-key' => @@wsc_api_key,
      :'wsc-access-key' => @@wsc_access_key
    ) { |response, request, result|
      case response.code
      when 301, 302, 307
        response.follow_redirection
      else
        data = JSON.parse(response)['live_stream']['source_connection_information']
        url = JSON.parse(response)['live_stream']['hosted_page_url']
        @stream = {
          id: JSON.parse(response)['live_stream']['id'],
          primary_server: data['primary_server'],
          host_port: data['host_port'],
          stream_name: data['stream_name'],
          hosted_page: url
        }
        render 'stream'
      end
    }
  end
end
