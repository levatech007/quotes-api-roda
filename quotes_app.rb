require "roda"
require "sequel"

# require "models"

DB = Sequel.connect(adapter: :postgres, database: 'quotes_app', host: 'localhost', user: 'galen')

class Quotes < Roda
  plugin :json
  plugin :json_parser
  require './models/quote.rb'
  route do |r|
    r.root do
      {'description'=>'Welcome to quotes API'}
    end

  r.on "quotes" do
      r.get do
        #return all quotes
        @quotes = Quote.all
        @quotes.map{ |quote| JSON.parse(quote.to_json) }
      end

      r.get /quotes\/([0-9]+)/ do |id|
        # return quote by id
        @quote = Quote[id]
        { quote: JSON.parse(@quote.to_json) }
      end

      r.post do
        # post a new quote
        @quote = Quote.create(quote_params(r))
        { quote: JSON.parse(@quote.to_json) }
      end
    end
  end #end of routes

  private

  def quote_params(r)
    { author: r.params['author'], quote: r.params['quote'] }
  end
end
