require "roda"
require "sequel"

database = "quotes_development"
user     = ENV["PGUSER"]
password = ENV["PGPASSWORD"]
DB = Sequel.connect(adapter: "postgres", database: database, host: "127.0.0.1", user: user, password: password)

class Quotes < Roda
  plugin :json
  route do |r|
    r.root do
      {'a'=>'b'}
    end
  end
end
