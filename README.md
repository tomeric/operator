# Operator

Operator is a Rails 3 plugin that simplifies sending and receiving messages to
and from [transmitter](http://github.com/tomeric/transmitter).

## Publishers

Publishers are used to publish messages to a transmitter server. They are very
simple classes that are inherited from the Operator::Publisher class. When 
writing a publisher, you only need to define the queue and the message.

    # The ArticleCreatedPublisher notifies all connected sites that an article
    # has just been created    
    class ArticleCreatedPublisher < Operator::Publisher
      publishes_to :created_articles
      
      def initialize(article)
        self.message = { :article_id => article.id }
      end
    end

## Subscribers

Subscribers are used to process messages that are received. If you create a 
subscriber, it will get it's own URL. The route to this URL will be created
for you automatically.

The URL generation is really simple. A subscriber called `ArticleSubscriber`
will get the URL `/operator/subscribers/article_subscriber`. You will need
to configure transmitter to send the messages to this URL.

    # The ArticleSubscriber responds to article creation notifications and
    # creates headlines that link to the article on a connected site.
    class ArticleSubscriber < Operator::Subscriber
      subscribes_to :created_articles
      
      def process(message)
        url  = "http://localhost:3000/articles/#{message[:article_id]}.json"
        body = open(url).read
        json = JSON.parse(body)
        
        Headline.create!(
          title:   json[:title],
          summary: json[:summary],
          url:     "http://localhost:3000/articles/#{message[:article_id]}.html"
        ) 
      end
    end

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Tom-Eric Gerritsen. See LICENSE for details.
