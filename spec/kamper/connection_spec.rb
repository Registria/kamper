require 'spec_helper'

describe Kamper::Connection do
  let(:config){ 
    { 
      :host => 'connecteddata.host4kb.com', 
      :path => '/api.php',
      :api_key => 'cb15faf01551d83aa1c6f517549531c5',
      :use_ssl => true
    } 
  }

  let(:connection){ Kamper::Connection.new(config) }

  describe '#client' do
    it 'returns an XMLRPC::Client instance' do
      connection.client.should be_an_instance_of XMLRPC::Client
    end
  end

  describe '#call' do
    it 'makes an XMLRPC call using client.call_async' do
      VCR.use_cassette('system.listMethods') do
        connection.client.expects(:call_async).with('system.listMethods', config[:api_key])
        connection.call('system.listMethods')
      end
    end

    it 'returns expected data from the endpoint' do
      VCR.use_cassette('system.listMethods') do
        connection.call('system.listMethods').should be_instance_of(Array) 
      end

      VCR.use_cassette('system.listMethods') do
        connection.call('system.listMethods').should include('get.Term.list') 
      end
    end
  end
end