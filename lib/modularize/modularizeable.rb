module Modularize
  module Modularizeable
    def modularize(*args)
      Modularizer.new(self, *args).modularize
    end
  end
end
