require "roda"

class Quotes < Roda
  plugin :json
  route do |r|
    r.root do
      {'a'=>'b'}
    end
  end
end
