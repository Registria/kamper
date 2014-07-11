require 'xmlrpc/base64'

module Kamper
  class Article
    class << self
      attr_accessor :connection

      def new_connection connection_hash
        raise "api_key required" unless connection_hash[:api_key]
        self.connection = Kamper::Connection.new({
          :host => connection_hash[:host] || 'connecteddata.host4kb.com', 
          :path => connection_hash[:path],
          :api_key => connection_hash[:api_key] || '/api.php',
          :use_ssl => connection_hash[:use_ssl] || true
        })
      end

      def find arcticle_id, public_only = true
        connection.call('get.Article', arcticle_id, public_only ? 'Y' : 'N')
      end

      def add title, content, *category_ids
        connection.call('add.Article', title, content, category_ids)
      end
      
      def recently_added args = {}
        get_articles('get.Article.list.recentlyAdded', args)
      end

      def recently_updated args = {}
        get_articles('get.Article.list.recentlyUpdated', args)
      end

      private

      def decode value
        XMLRPC::Base64.decode(value)
      end

      def get_articles cmd, args
        p = {
          :category_id => args[:category_id] || 0, 
          :starting_shift => args[:starting_shift] || 0, 
          :limit => args[:limit] || 10, 
          :public_only => args[:public_only].nil? ? 'Y' : (args[:public_only] ? 'Y' : 'N'), 
        }
        articles = connection.call(cmd, p[:category_id], p[:starting_shift], p[:limit], p[:public_only])
        articles.map do |article|
          article['question'] = decode article['question']
          article['answer'] = decode article['answer']
          article["categories"] = article["categories"].map do |category| 
            category["catName"] = decode category["catName"]
            category["fullPath"] = category["fullPath"].map do |fp|
              fp["catName"] = decode fp["catName"]
              fp
            end
            category
          end
          article
        end
      end
    end  
  end
end