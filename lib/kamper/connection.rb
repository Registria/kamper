require 'xmlrpc/client'

module Kamper
  class Connection
    attr_accessor :client, :config

    def initialize(cfg = {})
      @config = cfg
    end

    def client
      @client ||= XMLRPC::Client.new3(config)
    end

    def call method, *args
      attempts = 0
      begin
        call_args = [config[:api_key]] + args
        client.call_async(method, *call_args)
      rescue XMLRPC::FaultException => e
        attempts += 1
        retry if attempts < 2
      end
    end
  end
end