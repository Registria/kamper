
module Kamper
  class Article
    class << self
      attr_accessor :connection

      def find(arcticle_id, public_only = true)
        connection.call('get.Article', arcticle_id, public_only ? 'Y' : 'N')
      end

      def add(title, content, *category_ids)
        connection.call('add.Article', title, content, category_ids)
      end
      
      def recently_added(args = {})
        get_articles('get.Article.list.recentlyAdded', args)
      end

      def recently_updated(args = {})
        get_articles('get.Article.list.recentlyUpdated', args)
      end

      private

      def get_articles cmd, args
        p = {
          :category_id => args[:category_id] || 0, 
          :starting_shift => args[:starting_shift] || 0, 
          :limit => args[:limit] || 10, 
          :public_only => args[:public_only].nil? ? 'Y' : (args[:public_only] ? 'Y' : 'N'), 
        }
        connection.call(cmd, p[:category_id], p[:starting_shift], p[:limit], p[:public_only])
      end
    end  
  end
end