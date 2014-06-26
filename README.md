# Kamper

Ruby wrapper for the KnowledgeBase Manager Pro xmlrpc api

Usage Documentation: http://www.web-site-scripts.com/knowledge-base/article/AA-00508/84/XML-RPC
API Endpoint Documentation: https://connecteddata.host4kb.com/api.php

Note: This gem is currently targeted for REE/Ruby 1.8.7, but will add 1.9/2.1 branch if requested

## Installation

Add this line to your application's Gemfile:

    gem 'kamper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kamper

## Usage

### Connect to KnowledgeBase Manager Pro API using your credentials (use your own api key)
```
Kamper::Base.connection = Kamper::Connection.new({
  :host => 'connecteddata.host4kb.com', 
  :path => '/api.php',
  :api_key => YOUR_API_KEY_GOES_HERE,
  :use_ssl => true
})
```

### Add your HTML-formatted articles to your Knowledge Base
```
# For details, see https://connecteddata.host4kb.com/api.php?/showMethod/add.Article
Kamper::Article.add('My Latest Article', "<h1>Pariatur amet</h1>...", 1, 7)
Kamper::Article.add('An Even Later Article', "<em>Assumenda accusamus</em>...", 4, 7, 5, 2)
Kamper::Article.add('A Much, Much Later Article', "<code>assumenda praesentium</code>...", 18, 5)
```

### Grab an article or two from your Knowledge Base
```
# For details, see https://connecteddata.host4kb.com/api.php?/showMethod/get.Article
# Grab the public article AA-XXXXX
Kamper::Article.find('AA-XXXXX') 
  # => {"author_login"=>"Nathan Wind", "public"=>true, ...}

# Disable public only search to find the private article AA-YYYYY
Kamper::Article.find('AA-YYYYY', false) 
  # => {"author_login"=>"Brock Landers", "public"=>false, ...}
```

### List the most recently added articles
```
# For details, see https://connecteddata.host4kb.com/api.php?/showMethod/get.Article.list.recentlyAdded
# Using default params for 'get.Article.list.recentlyAdded'
Kamper::Article.recently_added
  # => {"articles"=>[{"lastEditDate"=>#<XMLRPC::DateTime:0x1076c56f8 @sec=11, ...}
```

### List the most recently updated articles
```
# For details, see https://connecteddata.host4kb.com/api.php?/showMethod/get.Article.list.recentlyUpdated
# Using default params for 'get.Article.list.recentlyUpdated'
Kamper::Article.recently_updated
  # => {"articles"=>[{"lastEditDate"=>#<XMLRPC::DateTime:0x107bcd3a8 @sec=11, ...}
```

## Contributing

1. Fork it ( https://github.com/marchyoung/kamper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
