require "roda"

class Quotes < Roda
  route do |r|
    r.root do
      "Hello World!"
    end
  end
end
