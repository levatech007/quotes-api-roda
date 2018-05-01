require "roda"
require "sequel"

# require "models"

DB = Sequel.connect(adapter: :postgres, database: 'quotes_app', host: 'localhost', user: 'galen')

class Quotes < Roda
  plugin :json
  require './models/quote.rb'
  route do |r|
    r.root do
      {'Hello'=>'world'}
    end

  r.on "quotes" do
      r.get do
        #return all quotes
        @quotes = Quote.all
        @quotes.map(&:to_json)
      end

      r.get /quotes\/([0-9]+)/ do |id|
        @quote = Quote[id]
        # return quote by id
      end

      r.post do
        # post a new quote
      end
    end
  end #end routes
end
