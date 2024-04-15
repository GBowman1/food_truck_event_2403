class Item
    attr_reader :name, :price

    def initialize(item)
        @name = item[:name]
        @price = item[:price].delete("$").to_f
        #delete $ from string, convert to float for math
    end
end