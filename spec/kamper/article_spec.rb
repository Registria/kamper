require 'spec_helper'

describe Kamper::Article do
  let(:config){ 
    { 
      :host => 'connecteddata.host4kb.com', 
      :path => '/api.php',
      :api_key => 'cb15faf01551d83aa1c6f517549531c5',
      :use_ssl => true
    } 
  }

  before do
    Kamper::Article.connection = Kamper::Connection.new(config)
  end

  describe '.add' do
    subject do
      VCR.use_cassette('add.Article') do
        Kamper::Article.add('My New Test Article', Faker::HTMLIpsum.body, 18, 7)
      end
    end

    it 'adds a new article to the knowledge base' do
      subject['done'].should be_true
      subject['title'].should == 'My-New-Test-Article'
      subject['code'].should_not be_empty
    end
  end

  describe '.find' do
    context 'article is public' do
      context 'and public only is not set or false' do
        it 'returns the public article' do
          VCR.use_cassette('get.Article.public.woflg') do
            Kamper::Article.find('AA-00426')['code'].should == 'AA-00426'
          end
        end
      end

      context 'and public only is false' do
        it 'returns the public article' do
          VCR.use_cassette('get.Article.public.wflg') do
            Kamper::Article.find('AA-00426', false)['code'].should == 'AA-00426'
          end
        end
      end
    end

    context 'article is private' do
      context 'and public only is not set or false' do
        it 'does not return the private article' do
          VCR.use_cassette('get.Article.private.woflg.wpermission') do
            Kamper::Article.find('AA-00402').should be_nil
          end
        end
      end

      context 'and public only is false' do
        context 'and user token allows access to this article' do
          it 'returns the private article' do
            VCR.use_cassette('get.Article.private.wflg.wpermission') do
              Kamper::Article.find('AA-00402', false)['code'].should == 'AA-00402'
            end
          end
        end
      end
    end
  end

  describe '.recently_added' do
    subject do 
      VCR.use_cassette('get.Article.list.recentlyAdded') do
        Kamper::Article.recently_added
      end
    end

    it 'returns the total number of articles with category id of ":category_id" (0 by default)' do
      subject['total'].should == 404
    end

    it 'limits the returned number of articles to :limit value (10 by default)' do
      subject['articles'].count.should == 10
    end

    it 'results starts with the article in the series (:starting_shift defaults to 0th/first article)' do
      subject['start'].should == 0
    end

    it 'returns public and accessible private articles based on :public_only (:public_only defaults to true)' do
      subject["articles"].reduce(true){|r, a| r && a["public"]}.should be_true
    end
  end

  describe '.recently_updated' do
    subject do 
      VCR.use_cassette('get.Article.list.recentlyUpdated') do
        Kamper::Article.recently_updated
      end
    end

    it 'returns the total number of articles with category id of ":category_id" (0 by default)' do
      subject['total'].should == 404
    end

    it 'limits the returned number of articles to :limit value (10 by default)' do
      subject['articles'].count.should == 10
    end

    it 'results starts with the article in the series (:starting_shift defaults to 0th/first article)' do
      subject['start'].should == 0
    end

    it 'returns public and accessible private articles based on :public_only (:public_only defaults to true)' do
      subject["articles"].reduce(true){|r, a| r && a["public"]}.should be_true
    end
  end
end