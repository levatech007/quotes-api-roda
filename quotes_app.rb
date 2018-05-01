require "roda"
require "sequel"

DB = Sequel.connect(adapter: :postgres, database: 'quotes_app', host: 'localhost', user: 'galen')

class Quotes < Roda
  plugin :json
  route do |r|
    r.root do
      {'Hello'=>'world'}
    end

  r.on "quotes" do
      r.get do
        {'Hello'=>'world...again'}
      end
    end
  end #end routes
end
