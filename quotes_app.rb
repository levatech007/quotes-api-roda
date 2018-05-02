require "roda"
require "sequel"

DB = Sequel.connect(adapter: :postgres, database: 'quotes_app', host: 'localhost', user: 'galen')

class Quotes < Roda
  plugin :json
  plugin :json_parser
  plugin :all_verbs
  plugin :halt
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

        r.post do
        #post a new quote
          @quote = Quote.create(quote_params(r))
          { quote: JSON.parse(@quote.to_json) }
        end
      end

      r.is 'quote', Integer do |quote_id|
        @quote = Quote[quote_id]

        r.halt(404) unless @quote

        r.get do
          { quote: JSON.parse(@quote.to_json) }
        end

        r.delete do
          @quote.destroy
          response.status = 200
          { deleted_quote: JSON.parse(@quote.to_json) }
        end
      end


  end #end of routes

  private

  def quote_params(r)
    { author: r.params['author'], quote: r.params['quote'] }
  end
end
