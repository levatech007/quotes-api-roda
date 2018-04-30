require "roda"
require "sequel"

DB = Sequel.connect(adapter: :postgres, database: 'quotes_app', host: 'localhost', user: 'galen')

class Quotes < Roda
  plugin :json
  route do |r|
    r.root do
      {'a'=>'b'}
    end
  end
end
